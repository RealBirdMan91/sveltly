<script lang="ts">
  import type { Raffle } from "$lib/types/raffle";
  import * as Card from "$lib/components/ui/card";
  import { Badge } from "$lib/components/ui/badge";
  import { cn } from "$lib/utils";
  import { Button } from "$lib/components/ui/button";
  import RafflesBadge from "$lib/components/shared/RafflesBadge.svelte";

  const { raffle }: { raffle: Raffle } = $props();
</script>

<Card.Root>
  <Card.Header class="flex flex-col items-center space-y-2">
    <div>
      <img
        class="h-[250px] aspect-square"
        src={raffle.image_path}
        alt={raffle.prize}
      />
    </div>
    <Card.Title class="text-neutral-700">{raffle.prize}</Card.Title>
  </Card.Header>
  <Card.Content class="space-y-2">
    <div class="flex justify-between items-center">
      <p class="text-neutral-700 font-medium">
        Price: {raffle.ticket_price}
      </p>
      <RafflesBadge status={raffle.status} />
    </div>
  </Card.Content>
  <Card.Footer class="space-x-4">
    <Button>Buy Ticket</Button>
    <Button
      variant="outline"
      href={`/raffles/${raffle.id}`}
      data-phx-link="redirect"
      data-phx-link-state="push"
    >
      View Details
    </Button>
  </Card.Footer>
</Card.Root>
