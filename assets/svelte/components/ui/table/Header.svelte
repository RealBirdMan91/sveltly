<script lang="ts">
  import type { HTMLAttributes } from "svelte/elements";
  import { cn } from "$lib/utils.js";
  import type { Snippet } from "svelte";

  interface Props extends HTMLAttributes<any> {
    class?: string;
    children: Snippet;
  }

  let { class: className, children, ...rest }: Props = $props();
</script>

<thead class={cn("[&_tr]:border-b", className)} {...rest}>
  {@render children()}
</thead>
