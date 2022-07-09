const inquirer = require('inquirer');

export async function evidenceFolderQuestion(): Promise<{evidenceFolder: string}> {
    return inquirer.prompt({
        type: 'input',
        name: 'evidenceFolder',
        message: 'Enter the name of the folder where u want generate files:',
        prefix: " 📁 ",
        default: "export-commits"
    });
}