<script lang="ts">
  import { type Variant, badgeVariants } from "./index.js";
  import { cn } from "$lib/utils.js";
  import type { Snippet } from "svelte";
  import type { HTMLAttributes } from "svelte/elements.js";

  interface Props extends HTMLAttributes<HTMLSpanElement | HTMLAnchorElement> {
    variant?: Variant;
    href?: string;
    class?: string | undefined | null;
    children: Snippet<[]>;
  }

  let {
    href,
    variant,
    children,
    class: className = undefined,
  }: Props = $props();
</script>

<svelte:element
  this={href ? "a" : "span"}
  {href}
  class={cn(badgeVariants({ variant, className }))}
>
  {@render children()}
</svelte:element>
