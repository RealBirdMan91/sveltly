<script lang="ts">
  import { cn } from "$lib/utils";
  import type { Snippet } from "svelte";
  import { getSelectContext } from "./ctx";
  import { melt } from "@melt-ui/svelte";
  import { fade } from "svelte/transition";

  type Props = {
    class?: string;
    transitionDuration?: number;
    children: Snippet;
  };

  const { select } = getSelectContext();
  const { menu } = select.elements;
  const { open } = select.states;

  let {
    class: className,
    transitionDuration = 150,
    children,
  }: Props = $props();
</script>

{#if $open}
  <div
    use:melt={$menu}
    class={cn(
      "bg-popover text-popover-foreground relative z-50 min-w-[8rem] overflow-hidden rounded-md border shadow-md outline-none",
      className
    )}
    transition:fade={{ duration: transitionDuration }}
  >
    {@render children()}
  </div>
{/if}
