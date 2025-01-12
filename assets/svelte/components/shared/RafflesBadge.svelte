<script lang="ts">
  import type { Raffle } from "$lib/types/raffle";
  import { cn } from "$lib/utils";
  import { Badge } from "../ui/badge";

  type Props = {
    status: Raffle["status"];
  };

  let { status }: Props = $props();
</script>

<Badge
  class={cn(
    status === "open" && "bg-blue-500",
    status === "upcoming" && "bg-neutral-400",
    status === "closed" && "bg-red-500",
    "text-white"
  )}>{status}</Badge
>
