import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
    return twMerge(clsx(inputs));
   }

   export type AsyncResult<T> = {
    loading: true,
    failed: false,
    result: null,
  } | {
    loading: false,
    failed: true,
    result: null,
  } | {
    loading: false,
    failed: false,
    result: T,
  }

export function isDataLoaded<T>(
    value: AsyncResult<T>
  ): value is { loading: false; failed: false; result: T } {
    return !value.loading && !value.failed;
  }
  