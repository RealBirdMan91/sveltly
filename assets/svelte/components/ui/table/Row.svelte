<script lang="ts">
  import type { HTMLAttributes } from "svelte/elements";
  import { cn } from "$lib/utils.js";
  import type { Snippet } from "svelte";

  interface Props extends HTMLAttributes<HTMLTableRowElement> {
    class?: string;
    children?: Snippet;
  }

  let { class: className, children, ...rest }: Props = $props();
</script>

<tr
  class={cn(
    "hover:bg-muted/50 data-[state=selected]:bg-muted border-b transition-colors",
    className
  )}
  {...rest}
>
  {@render children()}
</tr>
