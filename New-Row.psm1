
# Import Format Module
$items = Get-ChildItem "$PSScriptRoot\lib" -Recurse
foreach ($item in $items) {
    if ($item.Extension -eq '.psm1') {
        import-module $item.FullName
    }
}

Function  Switch-Expression($Type, $Value) {
    
    Switch ($Type) {


        'datetime2' {
            $Formated_Value = Format-DateTime2 $Value
            $Escaped_Value = Out-SqlEscape $Formated_Value
            $Sql_Expression = "CAST(NULLIF(RTRIM(LTRIM('$Escaped_Value')),'') AS datetime2)"
            Break
        }

        'datetime' {
            $Formated_Value = Format-DateTime $Value
            $Escaped_Value = Out-SqlEscape $Formated_Value
            $Sql_Expression = "CAST(NULLIF(RTRIM(LTRIM('$Escaped_Value')),'') AS datetime)"
            Break
        }
        
        'date' {
            $Formated_Value = Format-Date $Value
            $Escaped_Value = Out-SqlEscape $Formated_Value
            $Sql_Expression = "CAST(NULLIF(RTRIM(LTRIM('$Escaped_Value')),'') AS date)"
            Break
        }
        
        'bit' {
            $Formated_Value = Format-Func $Value
            $Escaped_Value = Out-SqlEscape $Formated_Value
            $Sql_Expression = "CAST(NULLIF(RTRIM(LTRIM('$Escaped_Value')),'') AS bit)"
            Break
        }

        default {
            $Sql_Expression = "'$Value'"
        }
    }
    return $Sql_Expression
}


class SqlRow {

    [string]$Column
    [string]$Expression

    SqlRow($Col,$Expr){

        $this.Format_Column($Col)
        $this.Add_Expression($Expr)
    }
    [void]Format_Column($val){
        $this.Column = "[$val]"
    }
    [void]Add_Expression($val) {
        $this.Expression = $val
    }
}





# deliverable Functions
Function New-Row {
    Param(
        [string]
        $Column,

        [object]
        $Value,

        [string]
        $Type
    )
    $Expression = Switch-Expression -Type $Type -Value $Value
    return [SqlRow]::new($Column,$Expression)
}
