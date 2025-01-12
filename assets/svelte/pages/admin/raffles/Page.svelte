<script lang="ts">
  import RafflesBadge from "$lib/components/shared/RafflesBadge.svelte";
  import * as Table from "$lib/components/ui/table";
  import type { Raffle } from "$lib/types/raffle";

  type Props = {
    raffles: Raffle[];
  };

  let { raffles }: Props = $props();

  // Funktion zum Formatieren des Datums in dd.mm.yyyy
  function formatDate(dateString: string) {
    const date = new Date(dateString);
    const day = String(date.getDate()).padStart(2, "0");
    const month = String(date.getMonth() + 1).padStart(2, "0");
    const year = String(date.getFullYear());

    return `${day}.${month}.${year}`;
  }
</script>

<div class="container m-auto flex flex-col gap-8">
  <h1 class="text-4xl text-neutral-800">Table of all Raffles</h1>

  <Table.Root>
    <Table.Caption>A List of all your Raffles</Table.Caption>
    <Table.Header>
      <Table.Row>
        <Table.Head>Prize</Table.Head>
        <Table.Head>Status</Table.Head>
        <Table.Head>Ticket Price</Table.Head>
        <Table.Head class="text-right">Inserted At</Table.Head>
      </Table.Row>
    </Table.Header>

    <Table.Body>
      {#each raffles as raffle}
        <Table.Row>
          <Table.Cell class="font-medium">{raffle.prize}</Table.Cell>
          <Table.Cell>
            <RafflesBadge status={raffle.status} />
          </Table.Cell>
          <Table.Cell>
            {#if raffle.ticket_price}
              {raffle.ticket_price}
            {:else}
              --
            {/if}
          </Table.Cell>
          <Table.Cell class="text-right"
            >{formatDate(raffle.inserted_at)}</Table.Cell
          >
        </Table.Row>
      {/each}
    </Table.Body>
  </Table.Root>
</div>
