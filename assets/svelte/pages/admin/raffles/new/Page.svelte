<script lang="ts">
  import Button from "$lib/components/ui/button/Button.svelte";
  import * as Form from "$lib/components/ui/form";
  import * as Select from "$lib/components/ui/select";
  import { useForm } from "$lib/hooks/useForm.svelte";
  import {
    RafflesSchema,
    type TRaffleSchema,
  } from "$lib/schemas/raffle_schema";
  import type { Raffle } from "$lib/types/raffle";
  import type { Live } from "live_svelte";

  type Props = {
    live: Live;
    defaultFormValues: Raffle;
  };

  let { live, defaultFormValues }: Props = $props();
  let loading = $state(false);

  const status = [
    { value: "upcoming", label: "Upcoming" },
    { value: "open", label: "Open" },
    { value: "closed", label: "Closed" },
  ];

  const { formState, handleSubmit, register } = useForm<TRaffleSchema>({
    initialValues: {
      ...defaultFormValues,
    },
    schema: RafflesSchema,
  });

  function onSubmitHandler(value: TRaffleSchema) {
    loading = true;
    live.pushEvent("create_raffle", { raffle: value }, () => {
      loading = false;
    });
  }
</script>

<section class="container m-auto flex flex-col gap-8">
  <h1 class="text-4xl text-neutral-800">Create Raffle:</h1>

  <form onsubmit={handleSubmit(onSubmitHandler)} class="flex flex-col gap-4">
    <Form.Field>
      <Form.Label for="prize">Prize</Form.Label>
      <Form.Input {...register("prize")} type="text" id="prize" name="prize" />
    </Form.Field>
    <Form.Field>
      <Form.Label for="description">Description</Form.Label>
      <Form.TextArea
        {...register("description")}
        id="description"
        name="description"
      />
    </Form.Field>
    <Form.Field>
      <Form.Label for="ticket_price">Ticket Price</Form.Label>
      <Form.Input
        {...register("ticket_price")}
        type="number"
        id="ticket_price"
        name="ticket_price"
      />
    </Form.Field>
    <Form.Field>
      <Form.Label for="status">Status</Form.Label>
      <Select.Root items={status} {...register("status")}>
        <Select.Trigger
          id="status"
          class="w-[180px]"
          defaultLabel="Select status"
        />
        <Select.Content>
          {#each status as { value: v, label: l }}
            <Select.Item value={v}>{l}</Select.Item>
          {/each}
        </Select.Content>
      </Select.Root>
    </Form.Field>
    <Form.Field>
      <Form.Label for="image_path">Image Path</Form.Label>
      <Form.Input
        {...register("image_path")}
        type="text"
        id="image_path"
        name="image_path"
      />
    </Form.Field>
    <Button type="submit" disabled={loading}>Create Raffle</Button>
  </form>
</section>
