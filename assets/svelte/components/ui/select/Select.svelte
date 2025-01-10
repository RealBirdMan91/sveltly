<script lang="ts" generics="T extends string">
  import { createSelect, type CreateSelectProps } from "@melt-ui/svelte";
  import type { ListboxOption } from "@melt-ui/svelte/dist/builders/listbox/types";
  import { setSelectContext } from "./ctx";
  import type { Snippet } from "svelte";
  import { writable, type Writable } from "svelte/store";
  import type { FloatingConfig } from "@melt-ui/svelte/internal/actions";

  interface SelectOption {
    value: T;
    label: string;
  }

  type Props = {
    required?: boolean;
    disabled?: boolean;
    preventScroll?: boolean;
    loop?: boolean;
    positioning?: CreateSelectProps<
      string,
      false,
      ListboxOption<string>
    >["positioning"];
    portal?: string | HTMLElement | null;
    name?: string;
    defaultOpen?: boolean;
    forceVisible?: boolean;
    typeahead?: boolean;
    children: Snippet;
    selected?: SelectOption | null;
    onSelectedChange?: (selected: SelectOption | null) => void;
  };

  const defaultPosition: FloatingConfig = {
    placement: "bottom",
    fitViewport: true,
    sameWidth: true,
  };
  let {
    required = false,
    disabled = false,
    preventScroll = true,
    loop = false,
    positioning = defaultPosition,
    portal = "body",
    name = "",
    defaultOpen = false,
    forceVisible = false,
    typeahead = false,

    children,

    selected = null,
    onSelectedChange = () => {},
  }: Props = $props();

  const internalSelectedStore: Writable<SelectOption | null> =
    writable(selected);

  const select = createSelect<T, false, SelectOption>({
    required,
    disabled,
    preventScroll,
    loop,
    positioning,
    portal,
    name,
    defaultOpen,
    forceVisible,
    typeahead,
    multiple: false, // Single-Select; bei Bedarf anpassen
    selected: internalSelectedStore,
  });

  $effect(() => {
    select.options.required.set(required);
    select.options.disabled.set(disabled);
    select.options.preventScroll.set(preventScroll);
    select.options.loop.set(loop);
  });

  $effect(() => {
    internalSelectedStore.set(selected);
  });

  const { selected: internalSelected } = select.states;
  $effect(() => {
    onSelectedChange($internalSelected);
  });

  setSelectContext({ select });
</script>

{@render children()}
