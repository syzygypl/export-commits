import { CLI } from "./cli";

export function index(): Promise<any> {
    return CLI();
}

index();