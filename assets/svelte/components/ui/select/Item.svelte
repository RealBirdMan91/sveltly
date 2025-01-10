<!-- src/lib/Select/Item.svelte -->
<script lang="ts">
  import type { Snippet } from "svelte";
  import { getSelectContext } from "./ctx";
  import { melt } from "@melt-ui/svelte";
  import { cn } from "$lib/utils";

  type Props = {
    value: string;
    disabled?: boolean;
    class?: string;
    children?: Snippet;
  };

  const { select } = getSelectContext();
  const { option } = select.elements;

  let {
    class: className = "",
    value,
    disabled = false,
    children,
  }: Props = $props();

  let container = $state<HTMLElement | null>(null);
  let labelText = $derived(() => container?.textContent?.trim() ?? "");
</script>

<div
  bind:this={container}
  use:melt={$option({ value, label: labelText(), disabled })}
  class={cn(
    "cursor-pointer px-3 py-1 rounded hover:bg-gray-100 data-[highlighted]:bg-gray-200 data-[disabled]:opacity-50",
    className
  )}
>
  {@render children()}
</div>
