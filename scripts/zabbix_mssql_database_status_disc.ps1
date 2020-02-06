# So this script works by accepting instance name and database name arguments,
# and checking whether that database is online

$instName = [string]$args[0]
$dbName = [string]$args[1]

if ($instName -and $dbName)
{
    $fullInstanceName = if ($instanceName -eq 'MSSQLSERVER') { $env:computername } else { "$env:computername\$instanceName" }
    $connectionString = "Server = $fullInstanceName; Integrated Security = True;"

    # Create a new connection object with that connection string
    $connection = New-Object System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = $connectionString
    # Try to open our connection, if it fails we won't try to run any queries
    try
    {
        $connection.Open()
    }
    catch
    {
        #Write-Host "Error connecting to $fullInstance!"
        $DataSet = $null
        $connection = $null
    }
    try
    {
        # Only run our queries if connection isn't null
        if ($connection -ne $null)
        {
            # Create a MSSQL request
            $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
            # Select the current instance name and database status 
            # where database = the database that was passed on the cmdline
            $SqlCmd.CommandText = "SELECT state_desc as state FROM sys.databases WHERE name='$dbName'"
            $SqlCmd.Connection = $Connection
            $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
            $SqlAdapter.SelectCommand = $SqlCmd
            $DataTable = New-Object System.Data.DataTable
            $SqlAdapter.Fill($DataTable) > $null
            $Connection.Close()
        }
    }
    catch
    {
        # If our query failed, set our dataset to null
        Write-Host "Error executing query on $fullInstance!"
        $DataTable = $null
    }
    # We get a set of database statuses. Append them to the basename variable.
    if ($DataTable -and $DataTable.Rows.Count)
    {
        if ($DataTable.Rows[0].state -like "ONLINE"){
            Write-Host "1"
        } else {
            Write-Host "0"
        }
    }
}