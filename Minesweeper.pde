import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons;
private ArrayList <MSButton> bombs;
private int bombNum;
int bombCount;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    Interactive.make( this );  
    bombNum = 70;
    buttons = new MSButton [NUM_ROWS][NUM_COLS];
    bombs = new ArrayList <MSButton>();
    for (int row = 0; row < NUM_ROWS; row++) 
    {
        for (int col = 0; col < NUM_COLS; col++) 
        {
            buttons[row][col] = new MSButton(row, col);
        }
    }  
    for (int bombSet = 0; bombSet < bombNum; bombSet++)
    {
        setBombs();
    }
}
public void setBombs()
{
    int row = (int)(Math.random() * NUM_ROWS);
    int col = (int)(Math.random() * NUM_COLS);
    if(bombs.contains(buttons[row][col]) == false)
    {
        bombs.add(buttons[row][col]);
        bombCount++;
    }
    else
    {
        bombNum++;
    }
}
public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
    if(isLost())
        displayLosingMessage();
}
public boolean isWon()
{
    for (int i = 0; i < bombs.size(); i++)
    {
        if (!bombs.get(i).isMarked())
        {
            return false;
        }
    }
    for (int h = 0; h < NUM_ROWS; h++)
    {
        for(int g = 0; g < NUM_COLS; g++)
        {
            if(!bombs.contains(buttons[h][g]) && buttons[h][g].isMarked())
            {
                return false;
            }
        }
    }
    return true;
}
public boolean isLost()
{
    for (int f = 0; f < bombs.size(); f++)
    {
        if (bombs.get(f).isClicked() && !bombs.get(f).isMarked())
        {
            return true;
        }
    }
    return false;
}
public void displayLosingMessage()
{
    textAlign(CENTER);
    stroke(255,0,0);
    buttons[NUM_ROWS/2][NUM_COLS/2-1].setLabel("You");
    buttons[NUM_ROWS/2][(NUM_COLS/2)+1].setLabel("Lose");
    for (int e = 0; e < bombs.size(); e++)
    {
        bombs.get(e).setClicked();
        bombs.get(e).setUnmarked();
    }
}
public void displayWinningMessage()
{
    textAlign(CENTER);
    stroke(0,0,255);
        buttons[NUM_ROWS/2][NUM_COLS/2-1].setLabel("You");
    buttons[NUM_ROWS/2][(NUM_COLS/2)+1].setLabel("Win");
}
public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;  
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    public void setUnmarked()
    {
        marked = false;
    }
    public void setClicked()
    {
        clicked = true;
    }
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed) {marked = !marked;}
        else if(bombs.contains( this )) {displayLosingMessage();}
        else if(countBombs(r, c) > 0) {setLabel(str(countBombs(r, c)));}
        else
        {
         	if (isValid(r-1, c-1) && buttons[r-1][c-1].isClicked() == false) {buttons[r-1][c-1].mousePressed();}
         	if (isValid(r-1, c) && buttons[r-1][c].isClicked() == false) {buttons[r-1][c].mousePressed();}
            if (isValid(r-1, c+1) && buttons[r-1][c+1].isClicked() == false) {buttons[r-1][c+1].mousePressed();}
            if (isValid(r, c-1) && buttons[r][c-1].isClicked() == false) {buttons[r][c-1].mousePressed();}
            if (isValid(r, c+1) && buttons[r-1][c+1].isClicked() == false) {buttons[r][c+1].mousePressed();}
			if (isValid(r+1, c-1) && buttons[r+1][c-1].isClicked() == false) {buttons[r+1][c-1].mousePressed();}
            if (isValid(r+1, c) && buttons[r+1][c].isClicked() == false) {buttons[r+1][c].mousePressed();}
            if (isValid(r+1, c+1) && buttons[r+1][c+1].isClicked() == false) {buttons[r+1][c+1].mousePressed();}
        }
    }
    public void draw () 
    {    
        if (marked) {fill(100);}
        else if(clicked && bombs.contains(this)) {fill(255,0,0);}
        else if(clicked) {fill( 255 );}
        else {fill( 50 );}
        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
    	if(r < NUM_ROWS && c < NUM_COLS && r >= 0 && c >= 0) {return true;}
    	else {return false;} 
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row, col))
        {
            if(bombs.contains(buttons[row-1][col-1])) {numBombs = numBombs + 1;}
            if(bombs.contains(buttons[row][col-1])) {numBombs = numBombs + 1;}
            if(bombs.contains(buttons[row+1][col-1])) {numBombs = numBombs + 1;}
            if(bombs.contains(buttons[row-1][col])) {numBombs = numBombs + 1;}
            if(bombs.contains(buttons[row+1][col])) {numBombs = numBombs + 1;}
            if(bombs.contains(buttons[row-1][col+1])) {numBombs = numBombs + 1;}
            if(bombs.contains(buttons[row][col+1])) {numBombs = numBombs + 1;}
            if(bombs.contains(buttons[row+1][col+1])) {numBombs = numBombs + 1;}
        }
        return numBombs;
    }
}



