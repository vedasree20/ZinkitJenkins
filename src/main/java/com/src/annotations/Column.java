package com.src.annotations;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Column {
    String name();                // column name in DB
    boolean nullable() default true;
    int length() default 255;     // for VARCHAR2
    String defaultValue() default "";
    boolean unique() default false;
}
