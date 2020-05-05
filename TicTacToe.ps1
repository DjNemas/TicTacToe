Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System

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

$XAML.Window.RemoveAttribute("x:Class")
#XAML laden
$Reader = New-Object System.Xml.XmlNodeReader $XAML
$Form = [Windows.Markup.XamlReader]::Load($Reader)


function CheckIfWon
{
    #Check FirstRow
    if($fld1.Player_1 -eq $true -and $fld2.Player_1 -eq $true -and $fld3.Player_1 -eq $true)
    {
    $player_1.Score += 1
    $scorePlayer1.Content = $player_1.Score
    $name = $player_1.Name
    $player_1.Turn = $false
    $player_2.Turn = $true
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld1.Player_2 -eq $true -and $fld2.Player_2 -eq $true -and $fld3.Player_2 -eq $true)
    {
    $player_2.Score += 1
    $scorePlayer2.Content = $player_2.Score
    $name = $player_2.Name
    $player_1.Turn = $true
    $player_2.Turn = $false
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    #Check SecondRow
    if($fld4.Player_1 -eq $true -and $fld5.Player_1 -eq $true -and $fld6.Player_1 -eq $true)
    {
    $player_1.Score += 1
    $scorePlayer1.Content = $player_1.Score
    $name = $player_1.Name
    $player_1.Turn = $false
    $player_2.Turn = $true
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld4.Player_2 -eq $true -and $fld5.Player_2 -eq $true -and $fld6.Player_2 -eq $true)
    {
    $player_2.Score += 1
    $scorePlayer2.Content = $player_2.Score
    $name = $player_2.Name
    $player_1.Turn = $true
    $player_2.Turn = $false
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    #Check ThirdRow
    if($fld7.Player_1 -eq $true -and $fld8.Player_1 -eq $true -and $fld9.Player_1 -eq $true)
    {
    $player_1.Score += 1
    $scorePlayer1.Content = $player_1.Score
    $name = $player_1.Name
    $player_1.Turn = $false
    $player_2.Turn = $true
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld7.Player_2 -eq $true -and $fld8.Player_2 -eq $true -and $fld9.Player_2 -eq $true)
    {
    $player_2.Score += 1
    $scorePlayer2.Content = $player_2.Score
    $name = $player_2.Name
    $player_1.Turn = $true
    $player_2.Turn = $false
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }

    #Check FirstColumn
    if($fld1.Player_1 -eq $true -and $fld4.Player_1 -eq $true -and $fld7.Player_1 -eq $true)
    {
    $player_1.Score += 1
    $scorePlayer1.Content = $player_1.Score
    $name = $player_1.Name
    $player_1.Turn = $false
    $player_2.Turn = $true
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld1.Player_2 -eq $true -and $fld4.Player_2 -eq $true -and $fld7.Player_2 -eq $true)
    {
    $player_2.Score += 1
    $scorePlayer2.Content = $player_2.Score
    $name = $player_2.Name
    $player_1.Turn = $true
    $player_2.Turn = $false
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    #Check SecondColumn
    if($fld2.Player_1 -eq $true -and $fld5.Player_1 -eq $true -and $fld8.Player_1 -eq $true)
    {
    $player_1.Score += 1
    $scorePlayer1.Content = $player_1.Score
    $name = $player_1.Name
    $player_1.Turn = $false
    $player_2.Turn = $true
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld2.Player_2 -eq $true -and $fld5.Player_2 -eq $true -and $fld8.Player_2 -eq $true)
    {
    $player_2.Score += 1
    $scorePlayer2.Content = $player_2.Score
    $name = $player_2.Name
    $player_1.Turn = $true
    $player_2.Turn = $false
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    #Check ThirdColumn
    if($fld3.Player_1 -eq $true -and $fld6.Player_1 -eq $true -and $fld9.Player_1 -eq $true)
    {
    $player_1.Score += 1
    $scorePlayer1.Content = $player_1.Score
    $name = $player_1.Name
    $player_1.Turn = $false
    $player_2.Turn = $true
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld3.Player_2 -eq $true -and $fld6.Player_2 -eq $true -and $fld9.Player_2 -eq $true)
    {
    $player_2.Score += 1
    $scorePlayer2.Content = $player_2.Score
    $name = $player_2.Name
    $player_1.Turn = $true
    $player_2.Turn = $false
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }

    #Check FirstDiagonal
    if($fld1.Player_1 -eq $true -and $fld5.Player_1 -eq $true -and $fld9.Player_1 -eq $true)
    {
    $player_1.Score += 1
    $scorePlayer1.Content = $player_1.Score
    $name = $player_1.Name
    $player_1.Turn = $false
    $player_2.Turn = $true
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld1.Player_2 -eq $true -and $fld5.Player_2 -eq $true -and $fld9.Player_2 -eq $true)
    {
    $player_2.Score += 1
    $scorePlayer2.Content = $player_2.Score
    $name = $player_2.Name
    $player_1.Turn = $true
    $player_2.Turn = $false
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    #Check SecondDiagonal
    if($fld3.Player_1 -eq $true -and $fld5.Player_1 -eq $true -and $fld7.Player_1 -eq $true)
    {
    $player_1.Score += 1
    $scorePlayer1.Content = $player_1.Score
    $name = $player_1.Name
    $player_1.Turn = $false
    $player_2.Turn = $true
    [System.Windows.Forms.MessageBox]::Show("$name Won","$name Won",0)
    InitialGame
    }
    elseif($fld3.Player_2 -eq $true -and $fld5.Player_2 -eq $true -and $fld7.Player_2 -eq $true)
    {
    $player_2.Score += 1
    $scorePlayer2.Content = $player_2.Score
    $name = $player_2.Name
    $player_1.Turn = $true
    $player_2.Turn = $false
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

function CheckPlayerClick (){

        [CmdLetBinding()]
		PARAM(
			[Parameter(Mandatory=$true)][object]$Fld, 
			[Parameter(Mandatory=$true)][object]$Fldimg
		)
if ($player_1.Turn -eq $true -and $Fld.Empty -eq $true)
    {
        $Fld.Empty = $false
        $Fldimg.Source = $button_x
        $Fld.Player_1 = $true
        $player_1.Turn = $false
        $player_2.Turn = $true        
        $curPlayer.Content = $player_2.Name
        $Fld.Button.IsEnabled = $false
    }
elseif($player_2.Turn -eq $true -and $Fld.Empty -eq $true)
{
        $Fld.Empty = $false
        $Fldimg.Source = $button_o
        $Fld.Player_2 = $true
        $player_1.Turn = $true
        $player_2.Turn = $false        
        $curPlayer.Content = $player_1.Name
        $Fld.Button.IsEnabled = $false
}

}

function InitialGame
{
foreach($item in $fld)
{
    $item.Empty = $true
    $item.Button.IsEnabled = $true
    $item.Player_1 = $false
    $item.Player_2 = $false
}
foreach($item in $fldimg)
{
    $item.Source = $button_transparent
}
$curPlayer.Content = $player_1.Name
}


#class bzw struktur

class Button
{    
    [ValidateNotNullOrEmpty()][object]$Button
    [bool]$Empty
    [bool]$Player_1
    [bool]$Player_2

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

#Variables
#Images
$button_transparent = "$PSScriptRoot/images/button_transparent.png"
$button_x = "$PSScriptRoot/images/button_x.png"
$button_o = "$PSScriptRoot/images/button_o.png"
#Player
$player_1 = [Player]@{Name = "Player 1"}
$player_2 = [Player]@{Name = "Player 2"}

#Button for obj Initialisation
$fld1 = [Button]@{Button = $Form.FindName('fld1')}
$fld2 = [Button]@{Button = $Form.FindName('fld2')}
$fld3 = [Button]@{Button = $Form.FindName('fld3')}
$fld4 = [Button]@{Button = $Form.FindName('fld4')}
$fld5 = [Button]@{Button = $Form.FindName('fld5')}
$fld6 = [Button]@{Button = $Form.FindName('fld6')}
$fld7 = [Button]@{Button = $Form.FindName('fld7')}
$fld8 = [Button]@{Button = $Form.FindName('fld8')}
$fld9 = [Button]@{Button = $Form.FindName('fld9')}

$fld = @($fld1, $fld2, $fld3, $fld4, $fld5, $fld6, $fld7, $fld8, $fld9)

#Header Initialisation
$curPlayer = $Form.FindName('curPlayer')
$scorePlayer1 = $Form.FindName('ScorePlayer1')
$scorePlayer2 = $Form.FindName('ScorePlayer2')
$scorePlayer1.Content = $player_1.Score
$scorePlayer2.Content = $player_2.Score

#Button_Image Array obj Initialisation
$fld1img = $Form.FindName('fld1_img')
$fld2img = $Form.FindName('fld2_img')
$fld3img = $Form.FindName('fld3_img')
$fld4img = $Form.FindName('fld4_img')
$fld5img = $Form.FindName('fld5_img')
$fld6img = $Form.FindName('fld6_img')
$fld7img = $Form.FindName('fld7_img')
$fld8img = $Form.FindName('fld8_img')
$fld9img = $Form.FindName('fld9_img')

$fldimg = @($fld1img, $fld2img, $fld3img, $fld4img, $fld5img, $fld6img, $fld7img, $fld8img, $fld9img)

#Set player 1 as first player
$player_1.Turn = $true
#Initial game values
InitialGame

#Event functions
$fld1_Click = 
{
    CheckPlayerClick -Fld $fld1 -Fldimg $fld1img
    CheckIfWon
}

$fld2_Click = 
{
    CheckPlayerClick -Fld $fld2 -Fldimg $fld2img
    CheckIfWon
}

$fld3_Click = 
{
    CheckPlayerClick -Fld $fld3 -Fldimg $fld3img
    CheckIfWon
}

$fld4_Click = 
{
    CheckPlayerClick -Fld $fld4 -Fldimg $fld4img
    CheckIfWon
}

$fld5_Click = 
{
    CheckPlayerClick -Fld $fld5 -Fldimg $fld5img
    CheckIfWon
}

$fld6_Click = 
{
    CheckPlayerClick -Fld $fld6 -Fldimg $fld6img
    CheckIfWon
}

$fld7_Click = 
{
    CheckPlayerClick -Fld $fld7 -Fldimg $fld7img
    CheckIfWon
}

$fld8_Click = 
{
    CheckPlayerClick -Fld $fld8 -Fldimg $fld8img
    CheckIfWon
}

$fld9_Click = 
{
    CheckPlayerClick -Fld $fld9 -Fldimg $fld9img
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


$Form.ShowDialog() | Out-Null