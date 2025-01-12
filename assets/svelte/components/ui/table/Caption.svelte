<script lang="ts">
  import type { HTMLAttributes } from "svelte/elements";
  import { cn } from "$lib/utils.js";
  import type { Snippet } from "svelte";

  interface Props extends HTMLAttributes<HTMLTableCaptionElement> {
    class?: string;
    children: Snippet;
  }

  let { class: className, children, ...rest }: Props = $props();
</script>

<caption class={cn("text-muted-foreground mt-4 text-sm", className)} {...rest}>
  {@render children()}
</caption>
