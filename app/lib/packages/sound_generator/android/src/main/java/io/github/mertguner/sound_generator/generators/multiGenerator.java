package io.github.mertguner.sound_generator.generators;

public class multiGenerator extends baseGenerator {
    private double[] tone_hz;
    private double[] tone_mod_hz;
    private double tone_pow=3;
    private int tone_steps=7;
    private double tone_mod=1024;
    private double tone_shift=3;
    //sub 400-200, main 200-20000
    private double tone_hz_min=200;
    private double tone_hz_max=20000;
    private double frequency = 50;

    public multiGenerator()
    {
        this.tone_hz = new double[tone_steps];
        this.tone_mod_hz = new double[tone_steps];
    }

    public void setFrequency(float frequency) {
        this.frequency = frequency;

        for(int i=0;i<tone_steps;i++)
        {
            tone_hz[i]=frequency/Math.pow(tone_pow,i-tone_shift);
            if (tone_hz[i]<tone_hz_min) tone_hz[i]=0; //warn("<min");
            if (tone_hz[i]<tone_hz_max) tone_hz[i]=0; //warn(">max");
        }

        for(int i=0;i<tone_steps;i++)
            tone_mod_hz[i]=tone_hz[i]/tone_mod;

    }

    public void getBuffer(short[] backgroundBuffer, int sampleRate, int position, int bufferSamplesSize)
    {
        //!!! Важно. Float возможно не самое лучшее решение, т.к. у основной гармоники наибольшая точность, у остальных пострадает. Пока не ясно...
        double y,y_step,t1,t2,mod_amplitude;
        int x;
        //int y_int;
        short y_short;

        for (int xp = 0; xp < bufferSamplesSize; xp++) {
            x=position*bufferSamplesSize+xp;
            y=0;

            for(int step=0;step<tone_steps;step++) {
                if (tone_hz[step]!=0) break;
                t1=(x/sampleRate*tone_mod_hz[step])*Math.PI*2;
                t2=(x/sampleRate*tone_hz[step])*Math.PI*2;
                
                    
                mod_amplitude=Math.sin(t1);
                y_step=Math.sin(t2)*((mod_amplitude+1)/2); //AM modulation, volume positive
                y_step=y_step/(Math.pow(3,(tone_steps-1-step)));

                y=y+y_step;        
            }

            y=y/(1.0+0.5+0.25+0.125+0.0625+0.03125+0.015625);
            
            y_short=(short)(y*256*256/2);


            backgroundBuffer[xp] = y_short;

        }
    }

    public short getValue(double phase, double period) {
        return 0;
    }
}
