<script lang="ts">
  import type { HTMLAttributes } from "svelte/elements";
  import { cn } from "$lib/utils.js";

  // Define the HeadingLevel type
  type HeadingLevel = "h1" | "h2" | "h3" | "h4" | "h5" | "h6";

  // Define the component's props interface
  interface Props extends HTMLAttributes<HTMLHeadingElement> {
    tag?: HeadingLevel;
  }

  // Destructure props with default values
  let {
    tag = "h3",
    class: className,
    children,
    ...restProps
  }: Props = $props();
</script>

<svelte:element
  this={tag}
  class={cn("text-lg font-semibold leading-none tracking-tight", className)}
  {...restProps}
>
  {@render children()}
</svelte:element>
