
export type CanStringify = string | number | bigint | boolean | null | undefined

export const FloatFormatter = (preces: number = 2) => {
    return (v: number): number => {
        return parseFloat(v.toFixed(preces))
    }
}

export const PercentFormatter = (preces: number = 2) => {
    return (v: number): string => {
        return `${FloatFormatter(preces)(v*100)} %`
    }
}

const DIGIT_PATTERN = /(^|\s)\d+(?=\.?\d*($|\s))/g;
const MILLI_PATTERN = /(?=(?!\b)(\d{3})+\.?\b)/g;

export const CurrencyFormatter = (prefix: string = "￥", preces: number = 2) => {
    return (v: number): string => {
        let minus = ""
        if (v < 0) {
            v *= -1;
            minus = "-"
        }
        const [value, decimal] = `${v.toFixed(preces)}`.split(".",2)

        let result = value.replace(DIGIT_PATTERN, (m) => m.replace(MILLI_PATTERN, ","))

        return `${prefix} ${minus}${result}.${decimal}`;

        // const split = Math.floor(value.length / 3)
        // const remain = value.length - split*3
        //
        // const results: string[] = [value.slice(0, remain)]
        // console.log(results)
        // for (let i = 0; i < split; i++) {
        //     results.push(value.slice(remain+i*3, remain+(i+1)*3))
        // }
        //
        // return `${prefix} ${minus}${results.join(",")}.${decimal}`
    }
}
