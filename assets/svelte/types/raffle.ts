/* Dies ist eine automatisch generierte Datei.
   Änderungen an diesem File könnten beim nächsten
   `mix gen.types` überschrieben werden!
*/
export interface Raffle {
  id: number;
  status: 'upcoming' | 'open' | 'closed';
  description: string;
  prize: string;
  ticket_price: number;
  image_path: string;
  inserted_at: string;
  updated_at: string;
}
