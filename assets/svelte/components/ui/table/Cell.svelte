<script lang="ts">
  import type { HTMLTdAttributes } from "svelte/elements";
  import { cn } from "$lib/utils.js";
  import type { Snippet } from "svelte";

  interface Props extends HTMLTdAttributes {
    class?: string;
    children?: Snippet;
  }
  let { class: className, children, ...rest }: Props = $props();
</script>

<td
  class={cn("p-4 align-middle [&:has([role=checkbox])]:pr-0", className)}
  {...rest}
>
  {@render children()}
</td>
