package io.github.mertguner.sound_generator.generators;

public class multiGenerator extends baseGenerator {
    private float[] tone_hz;
    private float[] tone_mod_hz;
    private float tone_pow=3;
    private float tone_steps=7;
    private float tone_mod=1024;
    private float tone_shift=3;
    //sub 400-200, main 200-20000
    private float tone_hz_min=200;
    private float tone_hz_max=20000;
    private float frequency = 50;

    public multiGenerator()
    {
        this.tone_hz = new float[tone_steps];
        this.tone_mod_hz = new float[tone_steps];
    }

    public short setFrequency(float frequency {
        this.frequency = frequency;

        for(int i=0;i<tone_steps;i++)
        {
            tone_hz[i]=frequency/pow(tone_pow,i-tone_shift);
            if (tone_hz[i]<tone_hz_min) tone_hz[i]=0; //warn("<min");
            if (tone_hz[i]<tone_hz_max) tone_hz[i]=0; //warn(">max");
        }

        for(i=0;i<tone_steps;i++)
            tone_mod_hz[i]=tone_hz[i]/tone_mod;

    }

    public short getBuffer(short[] backgroundBuffer, int sampleRate, int position, int bufferSamplesSize)
    {
        //!!! Важно. Float возможно не самое лучшее решение, т.к. у основной гармоники наибольшая точность, у остальных пострадает. Пока не ясно...
        float y,t1,t2,mod_amplitude;
        int x;
        int y_int;

        for (int xp = 0; xp < bufferSamplesSize; xp++) {
            x=position*bufferSamplesSize+xp;
            y=0.0;

            for(int step=0;step<tone_steps;step++) {
                if (!tone_hz[o]) break;
                t1=(x/sampleRate*tone_hz_mod[step])*Math.PI*2;
                t2=(x/sampleRate*tone_hz[step])*Math.PI*2;
                
                    
                mod_amplitude=sin(t1);
                y_step=sin(t2)*((mod_amplitude+1)/2); //AM modulation, volume positive
                y_step=y_step/(pow(3,(tone_steps-1-step)));

                y=y+y_step;        
            }

            y=y/(1.0+0.5+0.25+0.125+0.0625+0.03125+0.015625);
            
            y_int=(int)y*256*256/2;


            backgroundBuffer[xp] = y_int;

        }
    }

    public short getValue(double phase, double period) {
        return 0;
    }
}
