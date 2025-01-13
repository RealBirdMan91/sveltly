<script lang="ts">
  import { Input } from "$lib/components/ui/input";
  import * as Select from "$lib/components/ui/select";
  import type { Params } from "./Page.svelte";

  type Props = { values: Params; onFilterChange: (params: Params) => void };
  type Status = { value: Params["status"]; label: string };
  type SortBy = { value: Params["sort_by"]; label: string };

  let { values, onFilterChange }: Props = $props();

  const status: Status[] = [
    { value: "", label: "Select a status" },
    { value: "upcoming", label: "Upcoming" },
    { value: "open", label: "Open" },
    { value: "closed", label: "Closed" },
  ];
  const sort_by: SortBy[] = [
    { value: "", label: "Sort by" },
    { value: "prize", label: "Prize" },
    { value: "ticket_price", label: "Ticket Price" },
  ];
</script>

<div class="flex gap-2">
  <Input
    placeholder="Search"
    value={values.query}
    onkeyup={(e) =>
      onFilterChange({
        ...values,
        query: (e.target as HTMLInputElement).value,
      })}
  />
  <Select.Root
    items={status}
    selectedValue={values.status}
    onSelectedChange={(newVal) => {
      onFilterChange({ ...values, status: newVal });
    }}
  >
    <Select.Trigger class="w-[180px]" defaultLabel="Select a status" />
    <Select.Content>
      {#each status as { value: v, label: l }}
        <Select.Item value={v}>{l}</Select.Item>
      {/each}
    </Select.Content>
  </Select.Root>

  <Select.Root
    items={sort_by}
    selectedValue={values.sort_by}
    onSelectedChange={(value) => {
      onFilterChange({ ...values, sort_by: value });
    }}
  >
    <Select.Trigger class="w-[180px]" defaultLabel="Sort by" />
    <Select.Content>
      {#each sort_by as { value: v, label: l }}
        <Select.Item value={v}>{l}</Select.Item>
      {/each}
    </Select.Content>
  </Select.Root>
</div>
