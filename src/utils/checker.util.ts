import fs from 'fs';
import {showError} from "./logger.util";

export const checkExistence = (path: string): boolean => {
    return fs.existsSync(process.cwd() + path);
};

export const checkGitExist = (path: string): boolean => {
    return checkExistence(`${path}/.git`);
}

export const checkIfSymLinkFolderExist = () => {
    const dir = checkExistence('/projects');

    if (!dir) {
        showError('Create a projects/ directory and create symlinks to your projects there');
        process.exit(1);
    }
}