<script lang="ts">
  import type { Raffle } from "$lib/types/raffle";
  import type { Live } from "live_svelte";
  import RaffleCard from "./RaffleCard.svelte";
  import FilterForm from "./FilterForm.svelte";
  export type Params = {
    query: string;
    status: "upcoming" | "open" | "closed" | "";
    sort_by: "prize" | "ticket_price" | "";
  };

  type Props = {
    raffles: Raffle[];
    live: Live;
    params: Params;
  };
  let { raffles, live, params }: Props = $props();
</script>

<section class="container mx-auto p-4 flex flex-col space-y-6">
  <h1 class="text-4xl text-neutral-800">Raffles</h1>
  <FilterForm
    values={params}
    onFilterChange={(val) => {
      live.pushEvent("filter", val);
    }}
  />
  <ul class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
    {#each raffles as raffle}
      <li>
        <RaffleCard {raffle} />
      </li>
    {/each}
  </ul>
</section>
