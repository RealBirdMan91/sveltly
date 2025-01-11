<script lang="ts">
  import { Badge } from "$lib/components/ui/badge";
  import type { Raffle } from "$lib/types/raffle";
  import { type AsyncResult, isDataLoaded } from "$lib/utils";

  type Props = {
    raffle: Raffle;
    featured_raffles: AsyncResult<Raffle[]>;
  };
  let { raffle, featured_raffles }: Props = $props();
</script>

<div class="raffle-show container">
  <div class="raffle">
    <img src={raffle.image_path} alt={raffle.prize} />
    <section>
      <Badge>{raffle.status}</Badge>
      <header>
        <h2>{raffle.prize}</h2>
        <div class="price">{raffle.ticket_price}$ / per ticket</div>
      </header>
      <div class="description">{raffle.description}</div>
    </section>
  </div>
  <div class="activity">
    <div class="left"></div>
    <div class="right">
      <h4>Featured Raffles</h4>
      <ul class="raffles">
        {#if featured_raffles.loading}
          <li>Loading...</li>
        {/if}
        {#if featured_raffles.failed}
          <li>Error</li>
        {/if}
        {#if isDataLoaded(featured_raffles)}
          {#each featured_raffles.result as raffle}
            <li>
              <a
                href={`/raffles/${raffle.id}`}
                data-phx-link="redirect"
                data-phx-link-state="push"
              >
                <img src={raffle.image_path} alt={raffle.prize} />
                <span>{raffle.prize}</span>
              </a>
            </li>
          {/each}
        {/if}
      </ul>
    </div>
  </div>
</div>
