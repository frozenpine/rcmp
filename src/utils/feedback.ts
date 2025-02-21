import type {MessageApi} from "naive-ui"

export function useMessage(): MessageApi {
    return (window as any).$message
}