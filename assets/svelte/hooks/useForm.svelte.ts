import {ZodType} from 'zod';

type Params<FormData> = {
  initialValues: FormData;
  schema: ZodType<FormData>;
}
type FieldErrors<FormData> = Partial<Record<keyof FormData, { message: string }>>;
type FormState<FormData> = {
  values: FormData;
  errors: FieldErrors<FormData>;
}

export function useForm<FormData>({initialValues, schema}: Params<FormData>){
  const formState = $state<FormState<FormData>>({
    values: initialValues,
    errors: {}
  })

  function register<Key extends keyof FormData>(name: Key){
    return {
      name,
      value: formState.values[name],
      oninput: (e: Event) => {
        const target = e.target as HTMLInputElement
        formState.values[name] = target.value as FormData[Key]
      },
      selectedValue: formState.values[name], 
      onSelectedChange: (newVal: unknown) => {
        formState.values[name] = newVal as FormData[Key];
      },
    }
  }


  function handleSubmit(callback: (values: FormData) => void) {
    return (e: Event) => {
      e.preventDefault()
      formState.errors = {}
      
      const result = schema.safeParse(formState.values)
      if(!result.success) {
        const newErrors: FieldErrors<FormData> = {}
        for(const issue of result.error.issues) {
          const field = issue.path[0] as keyof FormData
          newErrors[field] = { message: issue.message }
        }
        formState.errors = newErrors
        return
      }
      
      callback(formState.values)
    }
  }
  


  return {
    formState,
    register,
    handleSubmit,
  }
}