import { red } from 'kleur';
import {AnswerDate} from "../models/answer-date";
const inquirer = require('inquirer');
inquirer.registerPrompt("date", require("inquirer-date-prompt"));

export async function dateQuestion(): Promise<AnswerDate> {
    return inquirer.prompt([{
        type: 'date',
        name: 'date',
        format: { month: "short", day: undefined, hour: undefined, minute: undefined },
        message: "Select a date:",
        prefix: " 📅 ",
        locale: "en-EN"
    }]);
}