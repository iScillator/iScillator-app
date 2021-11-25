package io.github.mertguner.sound_generator.generators;

public class multiGenerator extends baseGenerator {
    private double[] tone_hz;
    private double[] tone_mod_hz;
    private double tone_pow=3;
    private int tone_steps=7;
    private double tone_mod=1024;
    private double tone_shift=3;
    //sub 400-200, main 200-20000
    //all
    private double tone_hz_min=25;
    private double tone_hz_max=20000;
    private double frequency = 50;

    private int audio=0;

    public multiGenerator()
    {
        this.tone_hz = new double[tone_steps];
        this.tone_mod_hz = new double[tone_steps];
    }

    public void setParams(double modulation,double audio) {
        if(modulation==-1) this.tone_pow=1;
        if(modulation==2) this.tone_pow=2;
        if(modulation==3) this.tone_pow=3;
        if(modulation==5) this.tone_pow=5;
        if(modulation==23) this.tone_pow=1.58496250072;
        if(modulation==74) this.tone_pow=7.0/4.0;

        this.audio=(int)audio;

        //this.tone_pow = tone_pow;
        //this.tone_shift = tone_shift;
        android.util.Log.d("SoundHealer", "tone_shift="+tone_shift);
        android.util.Log.d("SoundHealer", "audio="+this.audio);
    }

    public void setFrequency(float frequency) {
        this.frequency = frequency;
        android.util.Log.d("SoundHealer", "frequency="+frequency);
        
        tone_shift=3;
        
        if (frequency>400000) tone_shift=-4;
        if (frequency>900000) tone_shift=-4;
        if (frequency>1900000) tone_shift=-5;

        android.util.Log.d("SoundHealer", "tone_shift="+tone_shift);
        for(int i=0;i<tone_steps;i++)
        {
            tone_hz[i]=frequency/Math.pow(tone_pow,i-tone_shift);
            if (tone_hz[i]<tone_hz_min) {android.util.Log.d("SoundHealer", tone_hz[i]+"<min => 0"); tone_hz[i]=0; }
            if (tone_hz[i]>tone_hz_max) {android.util.Log.d("SoundHealer", tone_hz[i]+">max => 0"); tone_hz[i]=0; }
            android.util.Log.d("SoundHealer", "tone_hz["+i+"]="+tone_hz[i]);
        }

        for(int i=0;i<tone_steps;i++)
            tone_mod_hz[i]=tone_hz[i]/tone_mod;

    }

    public void getBuffer(short[] backgroundBuffer, int sampleRate, int position, int bufferSamplesSize)
    {
        android.util.Log.d("SoundHealer/multi/getBuffer", "sampleRate="+sampleRate+",position="+position+",bufferSamplesSize="+bufferSamplesSize);
        //!!! Важно. Float возможно не самое лучшее решение, т.к. у основной гармоники наибольшая точность, у остальных пострадает. Пока не ясно...
        double y,y_step,t1,t2,mod_amplitude;
        int x;
        //int y_int;
        short y_short;

        android.util.Log.d("SoundHealer", "Buffer start position="+position);

        for (int xp = 0; xp < bufferSamplesSize; xp++) {
            x=(position*bufferSamplesSize)+xp;
            /*
            y=0;

            for(int step=0;step<tone_steps;step++) {
                if (tone_hz[step]==0) continue;
                t1=(x/sampleRate*tone_mod_hz[step])*Math.PI*2;
                t2=(x/sampleRate*tone_hz[step])*Math.PI*2;
                
                    
                mod_amplitude=Math.sin(t1);
                y_step=Math.sin(t2)*((mod_amplitude+1)/2); //AM modulation, volume positive
                y_step=y_step/(Math.pow(tone_pow,(tone_steps-1-step)));

                y=y+y_step;        
            }

            y=y/(1.0+0.5+0.25+0.125+0.0625+0.03125+0.015625);
            
            //y_short=(short)(y*256*256/2);
            y_short=(short)(y*Short.MAX_VALUE)


             = y_short;
            */
            backgroundBuffer[xp]=(short) (Short.MAX_VALUE * Math.sin(x/100000));
        
        }
        
        android.util.Log.d("SoundHealer", "Buffer end"+(int)(position*bufferSamplesSize));

        android.util.Log.d("SoundHealer", "Buffer end");
    }

    public short getValue(double phase, double period) {
        return 0;
    }

    public short getValuePos(int xp, int sampleRate, int position, int bufferSamplesSize, int channel) {
        double y,y_step,t1,t2,mod_amplitude;
        int x;
        short y_short;

        x=(position*bufferSamplesSize)+xp;


        y=0;

        for(int step=0;step<tone_steps;step++) {
            if (tone_hz[step]==0) continue;
            t1=(tone_mod_hz[step]*x/sampleRate)*Math.PI*2;
            t2=(tone_hz[step]*x/sampleRate)*Math.PI*2;
            
            if (audio==90) {
                if(channel==2) t1=t1+(Math.PI*2/4);
                if(channel==2) t2=t2+(Math.PI*2/4);
            }
            if (audio==120) {
                if(channel==2) t1=t1+(Math.PI*2/3);
                if(channel==2) t2=t2+(Math.PI*2/3);
            }
            if (audio==180) {
                if(channel==2) t1=t1+(Math.PI*2/2);
                if(channel==2) t2=t2+(Math.PI*2/2);
            }
                
            mod_amplitude=Math.sin(t1);
            y_step=Math.sin(t2)*((mod_amplitude+1)/2); //AM modulation, volume positive
            y_step=y_step/(Math.pow(tone_pow,(tone_steps-1-step)));

            y=y+y_step;        
        }

        y=y/(1.0+0.5+0.25+0.125+0.0625+0.03125+0.015625);
        
        //y_short=(short)(y*256*256/2);
        y_short=(short)(y*Short.MAX_VALUE);
        return y_short;

        //return (short) (Short.MAX_VALUE * Math.sin(1000.0*x/sampleRate*Math.PI*2));
    }
}
