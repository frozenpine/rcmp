import type {MessageApi, NotificationApi} from "naive-ui"

export function useMessage(): MessageApi {
    return (window as any).$message
}

export function useNotification(): NotificationApi {
    return (window as any).$notification
}