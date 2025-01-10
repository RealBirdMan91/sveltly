<script lang="ts">
  import { cn } from "$lib/utils";
  import { getSelectContext } from "./ctx";
  import { melt } from "@melt-ui/svelte";

  type Props = {
    class?: string;
    defaultLabel?: string;
  };

  // Kontext holen, um an "trigger" und "selectedLabel" zu kommen
  const { select } = getSelectContext();
  const { trigger } = select.elements;
  const { selectedLabel } = select.states;

  let { class: className, defaultLabel }: Props = $props();
</script>

<button
  use:melt={$trigger}
  class={cn(
    "border-input bg-background ring-offset-background focus-visible:ring-ring aria-[invalid]:border-destructive data-[placeholder]:[&>span]:text-muted-foreground flex h-10 w-full items-center justify-between rounded-md border px-3 py-2 text-sm focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 [&>span]:line-clamp-1",
    className
  )}
>
  {$selectedLabel || (defaultLabel && defaultLabel)}
  <svg
    xmlns="http://www.w3.org/2000/svg"
    fill="none"
    viewBox="0 0 24 24"
    stroke-width="1.5"
    stroke="currentColor"
    class="h-4 w-4 opacity-50"
  >
    <path
      stroke-linecap="round"
      stroke-linejoin="round"
      d="m19.5 8.25-7.5 7.5-7.5-7.5"
    />
  </svg>
</button>
