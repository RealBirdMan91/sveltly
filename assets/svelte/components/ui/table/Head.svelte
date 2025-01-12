<script lang="ts">
  import type { HTMLThAttributes } from "svelte/elements";
  import { cn } from "$lib/utils.js";
  import type { Snippet } from "svelte";

  interface Props extends HTMLThAttributes {
    class?: string;
    children?: Snippet;
  }

  let { class: className, children, ...rest }: Props = $props();
</script>

<th
  class={cn(
    "text-muted-foreground h-12 px-4 text-left align-middle font-medium [&:has([role=checkbox])]:pr-0",
    className
  )}
  {...rest}
>
  {@render children()}
</th>
