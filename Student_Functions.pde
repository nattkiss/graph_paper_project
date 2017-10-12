//A whole lot of matrix arithmetric is needed for the quadratic regression.

//Displays matrix (for testing purposes).
void mPrint(float[][] m) {
  for (int i=0; i<m.length; i++) {
    for (int j=0; j<m[0].length; j++) {
      print(m[i][j] + "  ");
    }
    println();
  }
  println();
}

//Multiplies a matrix by a scalar.
float[][] mScalar(float[][] m, float c) {
  float[][] result = new float[m.length][m[0].length];
  for (int i=0; i<m.length; i++) {
    for (int j=0; j<m[0].length; j++) {
      result[i][j] = c*m[i][j];
    }
  }
  return result;
}

//Multiplies two matrices.
float[][] mMult(float[][] m1, float[][] m2) {
  int m1Rows = m1.length;
  int m1Columns = m1[0].length;
  int m2Rows = m2.length;
  int m2Columns = m2[0].length;

  if (m1Columns != m2Rows) return new float[0][0];

  //Multiply m1 and m2.
  float[][] result = new float[m1Rows][m2Columns];
  for (int i=0; i<m1Rows; i++) {
    for (int j=0; j<m2Columns; j++) {
      float entry_ij = 0;
      for (int k=0; k<m1Columns; k++) {
        entry_ij += m1[i][k]*m2[k][j];
      }
      result[i][j] = entry_ij;
    }
  }
  return result;
}

//Computes the transpose of a matrix.
float[][] mTrans(float[][] m) {
  int rows = m.length;
  int columns = m[0].length;

  float[][] result = new float[columns][rows];

  for (int i=0; i<rows; i++) {
    for (int j=0; j<columns; j++) {
      result[j][i] = m[i][j];
    }
  }

  return result;
}

//Returns the matrix formed by deleting the ith row and jth column from a given matrix.
float[][] submatrix(float[][] m, int i, int j) {
  float[][] result = new float[m.length-1][m.length-1];
  for (int p=0; p<m.length; p++) {
    for (int q=0; q<m.length; q++) {
      if (p < i && q < j) result[p][q] = m[p][q];
      else if (p < i && q > j) result[p][q-1] = m[p][q];
      else if (p > i && q < j) result[p-1][q] = m[p][q];
      else if (p > i && q > j) result[p-1][q-1] = m[p][q];
    }
  }
  return result;
}

//Computes the determinant of a matrix.
float mDet(float[][] m) {
  if (m.length == 1) return m[0][0];

  float det = 0;
  for (int j=0; j<m.length; j++) {
    float cofactor = pow(-1, j) * m[0][j] * mDet(submatrix(m, 0, j));
    det += cofactor;
  }

  return det;
}

//Computes the i,j-cofactor of a matrix.
float mCofactor(float[][] m, int i, int j) {
  return pow(-1, i+j) * mDet(submatrix(m, i, j));
}

//Computes matrix inverse.
float[][] mInverse(float[][] m) {
  float[][] cofactorMatrix = new float[m.length][m.length];
  for (int i=0; i<m.length; i++) {
    for (int j=0; j<m.length; j++) {
      cofactorMatrix[i][j] = mCofactor(m, i, j);
    }
  }
  float[][] adjugate = mTrans(cofactorMatrix);
  float[][] result = mScalar(adjugate, 1/mDet(m));
  return result;
}

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
// separating the two functions from the matrix algebra for clarity
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

void runQuadReg(ArrayList<String> instructions) {

  // load the instructions into the "instructions" arraylist.  anything more than
  // six lines won't fit in the menu, so be concise when writing your own instructions.
  instructions.clear();
  instructions.add("*** You are in Quadratic Regression mode ***");
  instructions.add("");
  instructions.add("Click to place points.");
  instructions.add("When you're done, press 'd' to create regression.");
  instructions.add("Press 's' to start over.");

  //Draws each point on the screen.
  for (Point p : quad.points) p.drawPoint(0,150,0);
  
  //Runs when the user finishes drawing points.
  if (quad.finished) {

    //Calculate and display the least-squares parabola.
    quad.calculateReg();
    quad.displayReg();
    
    //Update the points so they appear on top of the regression curve.
    for (Point p : quad.points) p.drawPoint(0,150,0);
  }
}


//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
// separating the two functions for clarity
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


void runCircle(ArrayList<String> instructions) {

  // load the instructions into the "instructions" arraylist.  anything more than
  // six lines won't fit in the menu, so be concise when writing your own instructions.
  instructions.clear();
  instructions.add("*** You are in Circle From Three Points mode ***");
  instructions.add("");
  instructions.add("Click to place points.");
  instructions.add("After the third point is placed, a circle will be drawn.");
  instructions.add("Press 's' to start over.");
  
  //Draws each point on the screen.
  for (Point p : circle.points) p.drawPoint(0,150,0);
  
  //When the user has drawn three points, the circle is declared finished.
  if (circle.points.size() == 3) circle.finished = true;

  //Runs when the user finishes drawing points.
  if (circle.finished) {

    //Calculate and display the circle.
    circle.calculateCircle();
    circle.displayCircle();
    
    //Update points so they lie on top of the circle.
    for (Point p : circle.points) p.drawPoint(0,150,0);
  }
}