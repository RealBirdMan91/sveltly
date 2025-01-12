<script lang="ts">
  import type { Snippet } from "svelte";

  type Props = {
    flash: Snippet;
    children: Snippet;
  };

  let { flash, children }: Props = $props();
</script>

<div class="app-layout">
  <header class="bg-primary text-white px-8 py-4">
    <nav class="flex justify-between items-center">
      <h3 class="cursor-pointer">
        <a
          class="text-inherit font-bold tracking-wider"
          href="/"
          data-phx-link="redirect"
          data-phx-link-state="push">Sveltly</a
        >
      </h3>
      <ul class="flex gap-4">
        <li>
          <a
            class="text-inherit"
            href="/"
            data-phx-link="redirect"
            data-phx-link-state="push">Home</a
          >
        </li>
        <li>
          <a
            class="text-inherit"
            href="/raffles"
            data-phx-link="redirect"
            data-phx-link-state="push">Raffles</a
          >
        </li>
        <li>
          <a
            class="text-inherit"
            href="/admin/raffles"
            data-phx-link="redirect"
            data-phx-link-state="push">Admin</a
          >
        </li>
      </ul>
    </nav>
  </header>

  <section class="flash">
    {@render flash?.()}
  </section>

  <!-- Hier kommt der eigentliche Inhalt (LiveViews etc.) -->
  <main>
    {@render children?.()}
  </main>

  <footer class="flex flex-1 bg-primary px-8 py-4 text-white justify-end">
    <h4>© 2025</h4>
  </footer>
</div>
