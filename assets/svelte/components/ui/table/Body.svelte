<script lang="ts">
  import type { HTMLAttributes } from "svelte/elements";
  import { cn } from "$lib/utils.js";
  import type { Snippet } from "svelte";

  interface Props extends HTMLAttributes<HTMLTableSectionElement> {
    class?: string;
    children: Snippet;
  }

  let { class: className, children, ...rest }: Props = $props();
</script>

<tbody class={cn("[&_tr:last-child]:border-0", className)} {...rest}>
  {@render children()}
</tbody>
