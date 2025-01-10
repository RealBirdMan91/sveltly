// src/lib/Select/ctx.ts
import { getContext, setContext } from 'svelte';
import type { createSelect} from '@melt-ui/svelte'; // od. ReturnType<typeof createSelect>

const SELECT_CONTEXT = Symbol('SELECT_CONTEXT');

type SelectCtxType = {
	select: ReturnType<typeof createSelect> // das Objekt, das `createSelect()` zurückgibt
	// optional: updateOption, falls du `getOptionUpdater` willst
};

export function setSelectContext(obj: SelectCtxType) {
	setContext(SELECT_CONTEXT, obj);
}

export function getSelectContext(): SelectCtxType {
	const ctx = getContext<SelectCtxType>(SELECT_CONTEXT);
	if (!ctx) {
		throw new Error('Select-* components must be used inside <Select.Root>');
	}
	return ctx;
}
