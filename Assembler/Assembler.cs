using System ;
using System.Text;

public class Assembler 
{
    public Assembler(string outFile )
    {
        this.OutFile = outFile ; 
        this.OpCodes = new Dictionary<string, string>() ; 
        this.Registers = new Dictionary<string, string>() ; 
        this.MachinCodes = new List<string>() ; 
        InitializeOpCodes() ; 
        InitializeRegisters() ; 

    }

    public string OutFile { get ; set ;}
    public Dictionary<string , string > OpCodes { get ; set ; }
    public Dictionary<string , string > Registers { get ; set ; }
    public List<string> MachinCodes { get ; set ; }
    private void InitializeRegisters()
    {
        this.Registers.Add("Zero" , "0000" ) ;
        this.Registers["d0"] = "0001";
        this.Registers.Add("d1" , "0010" ) ;
        this.Registers.Add("d2" , "0011" ) ;
        this.Registers.Add("d3" ,"0100" ) ;
        this.Registers.Add("a0" , "0101" ) ;
        this.Registers.Add("a1" , "0110" ) ;
        this.Registers.Add("a2" , "0111" ) ; 
        this.Registers.Add("a3" , "1000" ) ;
        this.Registers.Add("sr" , "1001" ) ;
        this.Registers.Add("ba" , "1010" ) ;
        this.Registers.Add("pc" , "1011" ) ;
    }

    private void InitializeOpCodes()
    {
        this.OpCodes.Add( "add" , "0000") ;  
        this.OpCodes.Add( "adda" , "0001") ; 
        this.OpCodes.Add( "sub" , "0010") ; 
        this.OpCodes.Add( "addi" , "0011") ; 
        this.OpCodes.Add( "and" , "0101") ; 
        this.OpCodes.Add( "sll" , "0110") ; 
        this.OpCodes.Add( "lw" , "0111") ; 
        this.OpCodes.Add( "sw" , "1001") ; 
        this.OpCodes.Add( "regclr" , "1011") ; 
        this.OpCodes.Add( "memclr" , "1000") ; 
        this.OpCodes.Add( "mov" , "1100") ; 
        this.OpCodes.Add( "cmp" , "1101") ; 
        this.OpCodes.Add( "bne" , "1110") ; 
        this.OpCodes.Add( "jmp" , "1111") ; 
    }

    public void ReadFromFile(string InputFile)
    {
        var lines = File.ReadAllLines(InputFile) ; 
        foreach(var line in lines )
        {
            string[] toks= line.Split() ;
            var o = toks[0].ToLower() ; 
            switch (o) 
            {
                case "add" : 
                    ConvertToMachineCode_Rformat(Op:OpCodes[o],rd:toks[1].ToLower().Trim(','), rs:toks[2].ToLower()); 
                    break ; 

                case "adda" : 
                    ConvertToMachineCode_Iformat(Op:OpCodes[o],rd:toks[1].ToLower().Trim(','), imm:toks[2].ToLower()) ; 
                    break ; 

                case "sub" : 
                    ConvertToMachineCode_Rformat(Op:OpCodes[o].Trim(',') ,rd:toks[1].ToLower().Trim(','), rs:toks[2].ToLower()); 
                    break ; 

                case "addi" : 
                     ConvertToMachineCode_Iformat(Op:OpCodes[o],rd:toks[1].ToLower().Trim(','), imm:toks[2].ToLower()) ; 
                    break ; 

                case "and" : 
                    ConvertToMachineCode_Rformat(Op:OpCodes[o],rd:toks[1].ToLower().Trim(','), rs:toks[2].ToLower()); 
                    break ; 

                case "sll" : 
                     ConvertToMachineCode_Iformat(Op:OpCodes[o],rd:toks[1].ToLower().Trim(','), imm:toks[2].ToLower()) ; 
                    break ; 

                case "lw" : 
                    ConvertToMachineCode_Iformat(Op:OpCodes[o],rd:toks[1].ToLower().Trim(','), imm:toks[2].ToLower()) ; 
                    break ; 

                case "sw" : 
                     ConvertToMachineCode_Iformat(Op:OpCodes[o],rd:toks[1].ToLower().Trim(','), imm:toks[2].ToLower()) ; 
                    break ; 

                case "regclr" :
                    ConvertToMachineCode_Jformat( Op:OpCodes[o],rd:toks[1].ToLower().Trim(',')) ; 
                    break ; 

                case "mov" : 
                     ConvertToMachineCode_Iformat(Op:OpCodes[o],rd:toks[1].ToLower().Trim(','), imm:toks[2].ToLower()) ; 
                    break ; 

                case "bne" : 
                    ConvertToMachineCode_Jformat( Op:OpCodes[o],rd:toks[1].ToLower().Trim(',')) ; 
                    break ; 

                case "jmp" :
                    ConvertToMachineCode_Jformat( Op:OpCodes[o],rd:toks[1].ToLower()) ;  
                    break ; 

                case "cmp" : 
                    ConvertToMachineCode_Rformat(Op:OpCodes[o].Trim(',') ,rd:toks[1].ToLower().Trim(','), rs:toks[2].ToLower()); 
                    break ; 

                case "memclr" : 
                    ConvertToMachineCode_Jformat( Op:OpCodes[o],rd:toks[1].ToLower().Trim(',')) ; 
                    break ; 
                default:
                    break ;    
            }

        }
    }

    private void ConvertToMachineCode_Jformat(string Op, string rd)
    {
        StringBuilder sb = new StringBuilder() ; 
        sb.Append( Op) ; 
        if( Registers.Keys.Contains( rd ))
        {
            sb.Append( Registers[rd] ).Append("00000000") ; 
        }
        else
        {
            var binary = Convert.ToString( int.Parse(rd) , 2).PadLeft(12, '0');
            sb.Append(binary) ; 
        }
        this.MachinCodes.Add( sb.ToString()) ;  
    }

    private void ConvertToMachineCode_Iformat(string Op, string rd, string imm)
    {
        StringBuilder sb = new StringBuilder() ; 
        var binary = Convert.ToString( int.Parse(imm) , 2).PadLeft(8, '0');
        sb.Append( Op).Append(Registers[rd]).Append(binary) ; 
        this.MachinCodes.Add( sb.ToString()) ;  
    }

    private void ConvertToMachineCode_Rformat(string Op, string rd, string rs)
    {
        StringBuilder sb = new StringBuilder() ; 
        sb.Append( Op).Append(Registers[rd]).Append(Registers[rs]).Append("0000") ;     ; 
        this.MachinCodes.Add( sb.ToString()) ; 
    }

    public void WriteToFile()
    {
        File.WriteAllLines( this.OutFile , this.MachinCodes ) ; 
        Console.WriteLine("Instructions were succesfully written to file!!") ; 
    }
}


public class Program
{
    public static void Main()
    {
        Assembler assembler = new Assembler("Instructions.txt") ; 
        assembler.ReadFromFile("assemblies.txt") ; 
        assembler.WriteToFile() ; 
    }
}