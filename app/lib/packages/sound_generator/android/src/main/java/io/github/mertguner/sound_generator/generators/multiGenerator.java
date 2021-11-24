package io.github.mertguner.sound_generator.generators;

public class multiGenerator extends baseGenerator {
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
            
            if(channel==2) t1=t1+(Math.PI*2/3);
            if(channel==2) t2=t2+(Math.PI*2/3);
                
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
