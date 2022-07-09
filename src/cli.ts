import {checkIfSymLinkFolderExist} from "./utils/checker.util";
import {showError, showInfo, showSuccess, showTitleAndBanner} from "./utils/logger.util";
import {dateQuestion} from "./questions";
import {getAuthor} from "./utils/git.util";
import {exportProjects} from "./utils/projects.util";
import {evidenceFolderQuestion} from "./questions/evidence-folder.question";

export async function CLI(): Promise<any> {
    showTitleAndBanner();
    checkIfSymLinkFolderExist();

    const { evidenceFolder } = await evidenceFolderQuestion();
    const { date } = await dateQuestion();
    date.toLocaleString('pl-PL', { timeZone: 'Europe/Warsaw' })
    date.setDate(1);
    date.setHours(0, 0, 0);

    const formatter = new Intl.DateTimeFormat('en', { month: 'long' });
    showInfo(`Exporting commits for ${formatter.format(date)}`);

    await exportProjects(date, evidenceFolder);
}
