<script lang="ts">
  import type { HTMLAttributes } from "svelte/elements";
  import { cn } from "$lib/utils.js";

  type Props = HTMLAttributes<HTMLDivElement>;
  let { class: className, children, ...rest }: Props = $props();
</script>

<div class={cn("flex items-center p-6 pt-0", className)} {...rest}>
  {@render children()}
</div>
