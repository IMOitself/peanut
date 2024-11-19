package imo.peanut;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.drawable.BitmapDrawable;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends Activity 
{
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        View view = findViewById(R.id.view);

        view.post(new Runnable() {
            @Override
            public void run() {
                drawCanvasOnView(view);
           }
        });
    }


    void drawCanvasOnView(View view){
        int width = view.getWidth();
        int height = view.getHeight();
        int textSize = height / 8;

        Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        Paint paint = new Paint();
        paint.setTextSize(textSize);
        paint.setColor(0xFFFFFFFF);

        canvas.drawText("UwU", 0, textSize, paint);

        view.setBackground(new BitmapDrawable(getResources(), bitmap));
    }
}
