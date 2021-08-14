/*
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const FabricCAServices = require('fabric-ca-client');
const { Wallets } = require('fabric-network');
const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

// capture network variables from config.json
const configPath = path.join(process.cwd(), 'config.json');
const configJSON = fs.readFileSync(configPath, 'utf8');
const config = JSON.parse(configJSON);
var connection_file = config.connection_file;
var appAdmin = config.appAdmin;
var appAdminSecret = config.appAdminSecret;
var userName = config.userName;
var orgMSPID = config.orgMSPID;
var caName = config.caName;

const filePath = path.join(process.cwd(), '/connection.yaml');
let fileContents = fs.readFileSync(filePath, 'utf8');
let connectionFile = yaml.safeLoad(fileContents);

async function main() {
    try {
        // Create a new CA client for interacting with the CA.
        const caURL = connectionFile.certificateAuthorities[caName].url;
        const ca = new FabricCAServices(caURL);
        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'wallet');
        const wallet = await Wallets.newFileSystemWallet(walletPath);

        // Check to see if we've already enrolled the admin user.
        const adminExists = await wallet.get(userName);
        if (adminExists) {
            console.log('An identity for the admin user "admin" already exists in the wallet');
            return;
        }

        // Enroll the admin user, and import the new identity into the wallet.

        const enrollment = await ca.enroll({ enrollmentID: appAdmin, enrollmentSecret: appAdminSecret });
        //const identity = X509WalletMixin.createIdentity(orgMSPID, enrollment.certificate, enrollment.key.toBytes());
        //wallet.import(userName, identity);
        const identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: orgMSPID,
            type: 'X.509',
        };
        await wallet.put(userName, identity);
        console.log('msg: Successfully enrolled admin user ' + userName + ' and imported it into the wallet');

    } catch (error) {
        console.error(`Failed to enroll admin user: ${userName} ${error}`);
        process.exit(1);
    }
}

main();
