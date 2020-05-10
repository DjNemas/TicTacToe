#Hallo Lieber Dozent! Ich entschuldige mich jetzt schon einmal für mein ach so tolles Englisch bei den Kommentaren :D
#Ich wünsche Ihnen einen schönen Tag und viel spaß mit dem Code, hoffentlich hab ich es übersichtlich genug gehalten. :)

#####################################
# Programm Developed by Denis Kliem #
# www.djnemas.de                    #
#####################################

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System
#region WPF String
$style = @"
<Window.Resources>
        <Style TargetType="Button">
            <Setter Property="Background" Value="White"/>
        </Style>
        <Style TargetType="Image">
            <Setter Property="Source" Value="$PSScriptRoot/images/button_transparent.png"/>
        </Style>
</Window.Resources>
"@
 
[xml]$XAML = @"
<Window x:Class="TicTacToe_Gui.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:TicTacToe_Gui"
        
        Title="MainWindow" Height="500" Width="500">    
    
    $style
    
    <Grid>
        
    <!--#region Header Row 1 und 2-->
    
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition/>
        </Grid.RowDefinitions>
        <DockPanel>
            <Label Content="Won:" HorizontalAlignment="Left" Margin="5, 5, 0, 0"/>
            <Label x:Name="ScorePlayer1" HorizontalAlignment="Left" Margin="0, 5, 0, 0"/>
        </DockPanel>
        <Label Content="Tic Tac Toe" HorizontalAlignment="Center" Margin="0,5,0,5"/>
        <DockPanel HorizontalAlignment="Right">
            <Label Content="Won:" HorizontalAlignment="Left" Margin="0, 5, 0, 0"/>
            <Label x:Name="ScorePlayer2" HorizontalAlignment="Left" Margin="0,5,5,0"/>
        </DockPanel>
        <Label x:Name="Player1Name" Grid.Row="1" Content="Player 1" HorizontalAlignment="left" Margin="5,0,0,0"/>
        <DockPanel Grid.Row="1" HorizontalAlignment="Center">
            <Label Content="Current Player:" HorizontalAlignment="Center"/>
            <Label x:Name="curPlayer" Content="Player" Grid.Row="1" HorizontalAlignment="Center"/>
        </DockPanel>
        <Label x:Name="Player2Name" Grid.Row="1" Content="Player 2" HorizontalAlignment="Right" Margin="0,0,5,0"/>
        
        <!--#endregion-->
        
    <!--#region Gamefield-->
        <Grid Grid.Row="2">
            <Grid.RowDefinitions>
                <RowDefinition/>
                <RowDefinition/>
                <RowDefinition/>
            </Grid.RowDefinitions>
            <Grid.ColumnDefinitions>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>

            <Button x:Name="fld1" Grid.Row="0" Grid.Column="0">
                <Image x:Name="fld1_img"/>
            </Button>
            <Button x:Name="fld2" Grid.Row="0" Grid.Column="1">
                <Image x:Name="fld2_img"/>
            </Button>
            <Button x:Name="fld3" Grid.Row="0" Grid.Column="2">
                <Image x:Name="fld3_img"/>
            </Button>
            <Button x:Name="fld4" Grid.Row="1" Grid.Column="0">
                <Image x:Name="fld4_img"/>
            </Button>
            <Button x:Name="fld5" Grid.Row="1" Grid.Column="1">
                <Image x:Name="fld5_img"/>
            </Button>
            <Button x:Name="fld6" Grid.Row="1" Grid.Column="2">
                <Image x:Name="fld6_img"/>
            </Button>
            <Button x:Name="fld7" Grid.Row="2" Grid.Column="0">
                <Image x:Name="fld7_img"/>
            </Button>
            <Button x:Name="fld8" Grid.Row="2" Grid.Column="1">
                <Image x:Name="fld8_img"/>
            </Button>
            <Button x:Name="fld9" Grid.Row="2" Grid.Column="2">
                <Image x:Name="fld9_img"/>
            </Button>

        </Grid>
        <!--#endregion-->
        
    </Grid>
</Window>
"@
#endregion

#region XAML Reader
#Try to load XAML
try{
    $Reader = New-Object System.Xml.XmlNodeReader $XAML
    $XAML.Window.RemoveAttribute("x:Class")
    $Form =[Windows.Markup.XamlReader]::Load($Reader)
} catch {
   Write-Host "Windows.Markup.XamlReader konnte nicht geladen werden. Mögliche Ursache: ungültige Syntax oder fehlendes .net"
}
#endregion

#region Functions
#Function to check which player clicked on button
function PlayerTurnClickLog
{
    [CmdLetBinding()]
		PARAM(
			[Parameter(Mandatory=$true)][object]$Fld
		)

if($player_1.Turn -eq $true)
    {
        $logtext = $player_1.Name + " Click on Button" + $fld.ButtonNumber
    }
    elseif($player_2.Turn -eq $true)
    {
        $logtext = $player_2.Name + " Click on Button" + $fld.ButtonNumber
    }
    Write-Log $logtext "UserInput"
}
#Function for creating logfile and cosole output
function Write-Log([string]$logtext, [string]$type)
{
	$logdate = get-date -format "dd-MM-yyy HH:mm:ss"
    if($type -eq "Dev")
	{
		$logtext = "[Dev] " + $logtext
		$text = "["+$logdate+"] - " + $logtext
		Write-Host $text -ForegroundColor Yellow
	}
	if($type -eq "UserInput")
	{
		$logtext = "[UserInput] " + $logtext
		$text = "["+$logdate+"] - " + $logtext
		Write-Host $text -ForegroundColor Green
	}
	$text >> $logfile
}
#Set Values when Player1 Won
function Player1WonSetValues
{
    $player_1.Score += 1
    $scorePlayer1.Content = $player_1.Score    
    $player_1.Turn = $false
    $player_2.Turn = $true
    $logtext = "[Set Player Values] " + $player_1.Name + 
    " Score: " + $player_1.Score +
    " Turn:" + $player_1.Turn
    Write-Log $logtext "Dev"
    return $name = $player_1.Name
}
#Set Values when Player2 Won
function Player2WonSetValues
{
    $player_2.Score += 1
    $scorePlayer2.Content = $player_2.Score    
    $player_1.Turn = $true
    $player_2.Turn = $false
    $logtext = "[Set Player Values] " + $player_2.Name + 
    " Score: " + $player_2.Score +
    " Turn:" + $player_2.Turn
    Write-Log $logtext "Dev"
    return $name = $player_2.Name
}
#Check if a Player won on every possible line, or if no one won
function CheckIfWon
{
    #Check FirstRow
    if($fld1.Player_1 -eq $true -and $fld2.Player_1 -eq $true -and $fld3.Player_1 -eq $true)
    {
    $name = Player1WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld1.Player_2 -eq $true -and $fld2.Player_2 -eq $true -and $fld3.Player_2 -eq $true)
    {
    $name = Player2WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    #Check SecondRow
    if($fld4.Player_1 -eq $true -and $fld5.Player_1 -eq $true -and $fld6.Player_1 -eq $true)
    {
    $name = Player1WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld4.Player_2 -eq $true -and $fld5.Player_2 -eq $true -and $fld6.Player_2 -eq $true)
    {
    $name = Player2WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    #Check ThirdRow
    if($fld7.Player_1 -eq $true -and $fld8.Player_1 -eq $true -and $fld9.Player_1 -eq $true)
    {
    $name = Player1WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld7.Player_2 -eq $true -and $fld8.Player_2 -eq $true -and $fld9.Player_2 -eq $true)
    {
    $name = Player2WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }

    #Check FirstColumn
    if($fld1.Player_1 -eq $true -and $fld4.Player_1 -eq $true -and $fld7.Player_1 -eq $true)
    {
    $name = Player1WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld1.Player_2 -eq $true -and $fld4.Player_2 -eq $true -and $fld7.Player_2 -eq $true)
    {
    $name = Player2WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    #Check SecondColumn
    if($fld2.Player_1 -eq $true -and $fld5.Player_1 -eq $true -and $fld8.Player_1 -eq $true)
    {
    $name = Player1WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld2.Player_2 -eq $true -and $fld5.Player_2 -eq $true -and $fld8.Player_2 -eq $true)
    {
    $name = Player2WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    #Check ThirdColumn
    if($fld3.Player_1 -eq $true -and $fld6.Player_1 -eq $true -and $fld9.Player_1 -eq $true)
    {
    $name = Player1WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld3.Player_2 -eq $true -and $fld6.Player_2 -eq $true -and $fld9.Player_2 -eq $true)
    {
    $name = Player2WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }

    #Check FirstDiagonal
    if($fld1.Player_1 -eq $true -and $fld5.Player_1 -eq $true -and $fld9.Player_1 -eq $true)
    {
    $name = Player1WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld1.Player_2 -eq $true -and $fld5.Player_2 -eq $true -and $fld9.Player_2 -eq $true)
    {
    $name = Player2WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    #Check SecondDiagonal
    if($fld3.Player_1 -eq $true -and $fld5.Player_1 -eq $true -and $fld7.Player_1 -eq $true)
    {
    $name = Player1WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld3.Player_2 -eq $true -and $fld5.Player_2 -eq $true -and $fld7.Player_2 -eq $true)
    {
    $name = Player2WonSetValues
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }

    #Check If no one Won
    if (
    $fld1.Empty -eq $false -and
    $fld2.Empty -eq $false -and
    $fld3.Empty -eq $false -and
    $fld4.Empty -eq $false -and
    $fld5.Empty -eq $false -and
    $fld6.Empty -eq $false -and
    $fld7.Empty -eq $false -and
    $fld8.Empty -eq $false -and
    $fld9.Empty -eq $false)
    {
    [System.Windows.Forms.MessageBox]::Show("No one Won","No Winner",0)
    InitialGame
    }
    
}
#When player click on button change values
function CheckPlayerClick (){

        [CmdLetBinding()]
		PARAM(
			[Parameter(Mandatory=$true)][object]$Fld
		)
if ($player_1.Turn -eq $true -and $Fld.Empty -eq $true)
    {
        $Fld.Empty = $false
        $Fld.Image.Source = $button_x
        $Fld.Player_1 = $true
        $player_1.Turn = $false
        $player_2.Turn = $true        
        $curPlayer.Content = $player_2.Name
        $Fld.Button.IsEnabled = $false
        $logtext = "[Button Value Changes] Button" + $Fld.ButtonNumber +
        " Empty: " + $Fld.Empty +
        " Set Image: " + $Fld.Image.Source +
        " IsEnabled: " + $Fld.Button.IsEnabled
        Write-Log $logtext "Dev"
    }
elseif($player_2.Turn -eq $true -and $Fld.Empty -eq $true)
{
        $Fld.Empty = $false
        $Fld.Image.Source = $button_o
        $Fld.Player_2 = $true
        $player_1.Turn = $true
        $player_2.Turn = $false        
        $curPlayer.Content = $player_1.Name
        $Fld.Button.IsEnabled = $false
        $logtext = "[Button Value Changes] Button" + $Fld.ButtonNumber +
        " Empty: " + $Fld.Empty +
        " Set Image: " + $Fld.Image.Source +
        " IsEnabled: " + $Fld.Button.IsEnabled
        Write-Log $logtext "Dev"
}

}
#Reset the Buttons/Player Values
function InitialGame
{
foreach($item in $fld)
{
    $item.Empty = $true
    $item.Button.IsEnabled = $true
    $item.Player_1 = $false
    $item.Player_2 = $false
    $item.Image.Source = $button_transparent
    $logtext = "[Initial Buttons] " + "Button" + $item.ButtonNumber + 
    " Image: " + $item.Image.Source +
    " Empty:" + $item.Empty +
    " IsEnabled:" + $item.Button.IsEnabled +
    " Player1:" + $item.Player_1 +
    " Player2:" + $item.Player_1
    Write-Log $logtext "Dev"
}
}
#endregion

#region Classes
#class or rather structur
class Button
{    
    [ValidateNotNullOrEmpty()][object]$Button
    [object]$Image
    [bool]$Empty
    [bool]$Player_1
    [bool]$Player_2
    [ValidateNotNullOrEmpty()][int]$ButtonNumber

    Button() {
       $this.Empty = $true
       $this.Player_1 = $false
       $this.Player_2 = $false
    }
}

class Player
{   
    [ValidateNotNullOrEmpty()][string]$Name
    [bool]$Turn
    [int]$Score

    Player() {
    $this.Turn = $false
    $this.Score = 0
    }
}
#endregion

#region Logfile Variable
$logtext = ""
$path = "$PSScriptRoot\log"
$date = get-date -format "dd-MM-yyyy-HH-mm-ss"
$file = ("log-" + $date + ".log")
$logfile = $path + "\" + $file
#Create Folder Path if not exist
$checkFolder = Test-Path -PathType Container -Path $path
if ($checkFolder -eq $false)
{
    New-Item -ItemType Directory -Force -Path $path

    $logtext = "Folder for file path: " + $path + " created"
    Write-Log $logtext "Dev"
}else
{
    $logtext = "Path: " + $path + " allready exist."
    Write-Log $logtext "Dev"
}
#endregion

#region Variables

#Images
$button_transparent = "$PSScriptRoot/images/button_transparent.png"
$button_x = "$PSScriptRoot/images/button_x.png"
$button_o = "$PSScriptRoot/images/button_o.png"
#Player obj Initialisation
$player_1 = [Player]@{Name = "Player 1"}
$player_2 = [Player]@{Name = "Player 2"}

#Button obj Initialisation
$fld1 = [Button]@{Button = $Form.FindName('fld1'); Image = $Form.FindName('fld1_img'); ButtonNumber = 1}
$fld2 = [Button]@{Button = $Form.FindName('fld2'); Image = $Form.FindName('fld2_img'); ButtonNumber = 2}
$fld3 = [Button]@{Button = $Form.FindName('fld3'); Image = $Form.FindName('fld3_img'); ButtonNumber = 3}
$fld4 = [Button]@{Button = $Form.FindName('fld4'); Image = $Form.FindName('fld4_img'); ButtonNumber = 4}
$fld5 = [Button]@{Button = $Form.FindName('fld5'); Image = $Form.FindName('fld5_img'); ButtonNumber = 5}
$fld6 = [Button]@{Button = $Form.FindName('fld6'); Image = $Form.FindName('fld6_img'); ButtonNumber = 6}
$fld7 = [Button]@{Button = $Form.FindName('fld7'); Image = $Form.FindName('fld7_img'); ButtonNumber = 7}
$fld8 = [Button]@{Button = $Form.FindName('fld8'); Image = $Form.FindName('fld8_img'); ButtonNumber = 8}
$fld9 = [Button]@{Button = $Form.FindName('fld9'); Image = $Form.FindName('fld9_img'); ButtonNumber = 9}
#Array of Buttons for foreach
$fld = @($fld1, $fld2, $fld3, $fld4, $fld5, $fld6, $fld7, $fld8, $fld9)

#Header Initialisation
$curPlayer = $Form.FindName('curPlayer')
$scorePlayer1 = $Form.FindName('ScorePlayer1')
$scorePlayer2 = $Form.FindName('ScorePlayer2')
$scorePlayer1.Content = $player_1.Score
$scorePlayer2.Content = $player_2.Score
#endregion

#region Initial Game
#Set player 1 as first player
$player_1.Turn = $true
$curPlayer.Content = $player_1.Name
#Initial game values
InitialGame
#endregion

#region Events for every button
$fld1_Click = 
{
    PlayerTurnClickLog -Fld $fld1
    CheckPlayerClick -Fld $fld1
    CheckIfWon
}

$fld2_Click = 
{
    PlayerTurnClickLog -Fld $fld2
    CheckPlayerClick -Fld $fld2
    CheckIfWon
}

$fld3_Click = 
{
    PlayerTurnClickLog -Fld $fld3
    CheckPlayerClick -Fld $fld3
    CheckIfWon
}

$fld4_Click = 
{
    PlayerTurnClickLog -Fld $fld4
    CheckPlayerClick -Fld $fld4
    CheckIfWon
}

$fld5_Click = 
{
    PlayerTurnClickLog -Fld $fld5
    CheckPlayerClick -Fld $fld5
    CheckIfWon
}

$fld6_Click = 
{
    PlayerTurnClickLog -Fld $fld6
    CheckPlayerClick -Fld $fld6
    CheckIfWon
}

$fld7_Click = 
{
    PlayerTurnClickLog -Fld $fld7
    CheckPlayerClick -Fld $fld7
    CheckIfWon
}

$fld8_Click = 
{
    PlayerTurnClickLog -Fld $fld8
    CheckPlayerClick -Fld $fld8
    CheckIfWon
}

$fld9_Click = 
{
    PlayerTurnClickLog -Fld $fld9
    CheckPlayerClick -Fld $fld9
    CheckIfWon
}


#Events for Buttons
$fld1.Button.Add_Click($fld1_Click)
$fld2.Button.Add_Click($fld2_Click)
$fld3.Button.Add_Click($fld3_Click)
$fld4.Button.Add_Click($fld4_Click)
$fld5.Button.Add_Click($fld5_Click)
$fld6.Button.Add_Click($fld6_Click)
$fld7.Button.Add_Click($fld7_Click)
$fld8.Button.Add_Click($fld8_Click)
$fld9.Button.Add_Click($fld9_Click)
#endregion

$Form.ShowDialog() | Out-Null