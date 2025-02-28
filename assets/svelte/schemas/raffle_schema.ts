import {z} from "zod";

export const RafflesSchema = z.object({
    prize: z.string().nonempty(),
    description: z.string().nonempty().min(25),
    ticket_price:  z.coerce.number().positive().min(1).max(100),
    status: z.enum(["upcoming", "open", "closed"]),
    image_path: z.string(),
})

export type TRaffleSchema = z.infer<typeof RafflesSchema>;