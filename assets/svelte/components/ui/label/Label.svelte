<script lang="ts">
  import { cn } from "$lib/utils";
  import type { Snippet } from "svelte";
  import { createLabel, melt } from "@melt-ui/svelte";
  import type { HTMLLabelAttributes } from "svelte/elements";

  const {
    elements: { root },
  } = createLabel();

  interface Props extends HTMLLabelAttributes {
    class?: string;
    for: string;
    children: Snippet;
  }

  let { children, for: htmlFor, class: className }: Props = $props();
</script>

<label
  class={cn(
    "text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70",
    className
  )}
  for={htmlFor}
  use:melt={$root}>{@render children()}</label
>
