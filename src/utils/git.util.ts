import { execSync } from "child_process";

export async function getAuthor(projectPath: string) {
    return execSync(`git -C ${projectPath} config user.email`).toString()
}