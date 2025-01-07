<script lang="ts">
  import { buttonVariants, type ButtonVariants } from "./index";
  import type { ButtonRootProps } from "./types";
  import { cn } from "$lib/utils";

  type Props = ButtonRootProps & {
    class?: string;
    variant?: ButtonVariants["variant"];
    size?: ButtonVariants["size"];
  };

  let {
    href,
    type,
    children,
    ref = $bindable(),
    class: className,
    variant,
    size,
    ...restProps
  }: Props = $props();
</script>

<svelte:element
  this={href ? "a" : "button"}
  class={cn(buttonVariants({ variant, size }), className)}
  type={href ? undefined : type}
  {href}
  tabindex="0"
  bind:this={ref}
  {...restProps}
>
  {@render children?.()}
</svelte:element>
