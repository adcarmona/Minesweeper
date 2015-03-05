import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons;
private ArrayList <MSButton> bombs = new ArrayList <MSButton>();
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    Interactive.make( this );  
    buttons = new MSButton [NUM_ROWS][NUM_COLS];
    for(int row = 0; row < NUM_ROWS; row++)
    {
        for(int col = 0; col < NUM_COLS; col++) {buttons[row][col] = new MSButton(row, col);}
    }  
    setBombs();
}
public void setBombs()
{
    while(bombs.size() < 20)
    {
        int row = (int)(Math.random() * NUM_ROWS);
        int col = (int)(Math.random() * NUM_COLS);
        if(!bombs.contains(buttons[row][col])) {bombs.add(buttons[row][col]);}
    }
}
public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
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
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true) {marked = !marked;}
        else if(bombs.contains( this )) {displayLosingMessage();}
        else if(countBombs(r, c) > 0) {setLabel(str(countBombs(r, c)));}
        else
        {
         	if (buttons[r-1][c-1].isValid(r-1, c-1) == true && buttons[r-1][c-1].isClicked() == false) {buttons[r-1][c-1].mousePressed();}
         	if (buttons[r-1][c].isValid(r-1, c) == true && buttons[r-1][c].isClicked() == false) {buttons[r-1][c].mousePressed();}
            if (buttons[r-1][c+1].isValid(r-1, c+1) == true && buttons[r-1][c+1].isClicked() == false) {buttons[r-1][c+1].mousePressed();}
            if (buttons[r][c-1].isValid(r, c-1) == true && buttons[r][c-1].isClicked() == false) {buttons[r][c-1].mousePressed();}
            if (buttons[r][c+1].isValid(r, c+1) == true && buttons[r-1][c+1].isClicked() == false) {buttons[r][c+1].mousePressed();}
			if (buttons[r+1][c-1].isValid(r+1, c-1) == true && buttons[r+1][c-1].isClicked() == false) {buttons[r+1][c-1].mousePressed();}
            if (buttons[r+1][c].isValid(r+1, c) == true && buttons[r+1][c].isClicked() == false) {buttons[r+1][c].mousePressed();}
            if (buttons[r+1][c+1].isValid(r+1, c+1) == true && buttons[r+1][c+1].isClicked() == false) {buttons[r+1][c+1].mousePressed();}
        }
    }
    public void draw () 
    {    
        if (marked)
            fill(100);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 255 );
        else 
            fill( 10 );

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



