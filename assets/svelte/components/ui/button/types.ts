import type { Snippet } from "svelte";
import type { HTMLAnchorAttributes, HTMLButtonAttributes } from "svelte/elements";

type WithChildren<Props = {}> = Props & {
    children?: Snippet | undefined;
};
export type WithoutChildren<T> = T extends {
    children?: any;
} ? Omit<T, "children"> : T;

export type ButtonRootPropsWithoutHTML = WithChildren<{
    ref?: HTMLElement | null;
}>;

type AnchorElement = ButtonRootPropsWithoutHTML & WithoutChildren<Omit<HTMLAnchorAttributes, "href" | "type">> & {
    href: HTMLAnchorAttributes["href"];
    type?: never;
};
type ButtonElement = ButtonRootPropsWithoutHTML & WithoutChildren<Omit<HTMLButtonAttributes, "type" | "href">> & {
    type?: HTMLButtonAttributes["type"];
    href?: never;
};
export type ButtonRootProps = AnchorElement | ButtonElement;
