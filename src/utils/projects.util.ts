import fs from "fs";
import {Project} from "../models/project";
import {getAuthor} from "./git.util";
import addMonths from 'date-fns/addMonths'
import {showInfo, showSuccess} from "./logger.util";
import simpleGit from "simple-git";
import {Commit} from "../models/commit";
import {diffTemplate} from "../templates/diff";
const Diff2html = require('diff2html');
const path = require('path');

export function exportDiff(project: Project, commits: Commit[], until: Date, evidenceFolder: string) {
    commits.forEach(async (commit: Commit) => {
        const target = process.cwd() + `/${evidenceFolder}/${until.getFullYear()}/${until.getMonth()}/${project.name}/${commit.hash}.html`;
        const diff = await simpleGit(`./${project.path}`).show(commit.hash);
        const diffJson = Diff2html.parse(diff);
        const diffHtml = Diff2html.html(diffJson, {
            drawFileList: true,
            matching: 'lines'
        });
        fs.writeFile(target, diffTemplate(diffHtml), () => {});
    });

    showSuccess('Generated');
}

export async function exportProject(project: Project, since: Date, until: Date, evidenceFolder: string): Promise<any> {
    const author = await getAuthor(project.path);
    fs.mkdirSync(process.cwd() + `/${evidenceFolder}/${until.getFullYear()}/${until.getMonth()}/${project.name}`, { recursive: true });
    showInfo(`Generating history for ${project.name} between ${since.toISOString()} - ${until.toISOString()}`);
    const commits = await simpleGit(`./${project.path}`).log([
        `--author=${author.trim()}`,
        '--no-merges',
        '--branches',
        `--since=${since.toISOString()}`,
        `--until=${until.toISOString()}`
    ]);
    exportDiff(project, commits.all as Commit[], until, evidenceFolder);
}

export async function exportProjects(date: Date, evidenceFolder: string): Promise<Project[]> {
    const projectsPath = path.join(process.cwd(), 'projects');
    const projects: Project[] = fs.readdirSync(projectsPath)
        .filter(function (file) {
            const statSyncDirOnSymlink = fs.lstatSync(path.join(projectsPath, file));
            return statSyncDirOnSymlink.isDirectory() || statSyncDirOnSymlink.isSymbolicLink();
         })
        .map((project: string) => {
            const projectPathOrSymlink = path.join(projectsPath, project);
            return ({
                name: project,
                path: fs.lstatSync(projectPathOrSymlink).isSymbolicLink() ? fs.readlinkSync(projectPathOrSymlink) : projectPathOrSymlink
            });
        });

    const until = new Date(addMonths(date, 1));
    const since = date;

    await projects.forEach((project: Project) => {
        exportProject(project, since, until, evidenceFolder);
    })
    return projects;
}