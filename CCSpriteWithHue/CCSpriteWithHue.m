//
//  CCSpriteWithHue.m
//  CCSpriteWithHue-Sample
//
//  Created by Alexey Naumov on 02/11/13.
//  Copyright (c) 2013 Alexey Naumov. All rights reserved.


//  Disclaimer: the basics for hue rotation algorithm were taken from Apple's GLImageProcessing sample project:
//  https://developer.apple.com/library/ios/samplecode/GLImageProcessing/Introduction/Intro.html

#import "CCSpriteWithHue.h"
#import "cocos2d.h"

const GLchar * colorRotationShaderBody();
void hueMatrix(GLfloat mat[3][3], float angle);
void premultiplyAlpha(GLfloat mat[3][3], float alpha);

#pragma mark -

@interface CCSprite (UpdateColor)

-(void) updateColor;

@end

@implementation CCSpriteWithHue

-(id) initWithTexture:(CCTexture2D*)texture rect:(CGRect)rect rotated:(BOOL)rotated
{
    self = [super initWithTexture:texture rect:rect rotated:rotated];
    if (self)
    {
        _hue = 0.0;
        [self initShader];
    }
    return self;
}

- (void) initShader
{
    self.shaderProgram = [[[CCGLProgram alloc] initWithVertexShaderByteArray:ccPositionTextureA8Color_vert
                                                     fragmentShaderByteArray:colorRotationShaderBody()]
                          autorelease];
    [_shaderProgram addAttribute:kCCAttributeNamePosition index:kCCVertexAttrib_Position];
    [_shaderProgram addAttribute:kCCAttributeNameTexCoord index:kCCVertexAttrib_TexCoords];
    [_shaderProgram link];
    [_shaderProgram updateUniforms];
    
    _hueLocation = glGetUniformLocation(_shaderProgram->_program, "u_hue");
    _alphaLocation = glGetUniformLocation(_shaderProgram->_program, "u_alpha");
    [self updateColor];
}

- (void) updateColorMatrix
{
    [_shaderProgram use];
    GLfloat mat[3][3];
    hueMatrix(mat, _hue);
    premultiplyAlpha(mat, [self alpha]);
    glUniformMatrix3fv(_hueLocation, 1, GL_FALSE, (GLfloat *)&mat);
}

- (void) updateAlpha
{
    [_shaderProgram use];
    glUniform1f(_alphaLocation, [self alpha]);
}

- (GLfloat) alpha
{
    return _displayedOpacity / 255.0f;
}

- (void) setHue:(CGFloat)hue
{
    _hue = hue;
    [self updateColorMatrix];
}

-(void) updateColor
{
    [super updateColor];
    [self updateColorMatrix];
    [self updateAlpha];
}

@end

#pragma mark -

const GLchar * colorRotationShaderBody()
{
    return
"                                                               \n\
#ifdef GL_ES                                                    \n\
    precision mediump float;                                    \n\
#endif                                                          \n\
                                                                \n\
    varying vec2 v_texCoord;                                    \n\
    uniform sampler2D u_texture;                                \n\
    uniform mat3 u_hue;                                         \n\
    uniform float u_alpha;                                      \n\
                                                                \n\
    void main()                                                 \n\
    {                                                           \n\
        vec4 pixColor = texture2D(u_texture, v_texCoord);       \n\
        vec3 rgbColor = u_hue * pixColor.rgb;                   \n\
        gl_FragColor = vec4(rgbColor, pixColor.a * u_alpha);    \n\
    }                                                           \n\
";
}

void xRotateMat(float mat[3][3], float rs, float rc)
{
	mat[0][0] = 1.0;
	mat[0][1] = 0.0;
	mat[0][2] = 0.0;
    
	mat[1][0] = 0.0;
	mat[1][1] = rc;
	mat[1][2] = rs;
    
	mat[2][0] = 0.0;
	mat[2][1] = -rs;
	mat[2][2] = rc;
}

void yRotateMat(float mat[3][3], float rs, float rc)
{
	mat[0][0] = rc;
	mat[0][1] = 0.0;
	mat[0][2] = -rs;
    
	mat[1][0] = 0.0;
	mat[1][1] = 1.0;
	mat[1][2] = 0.0;
    
	mat[2][0] = rs;
	mat[2][1] = 0.0;
	mat[2][2] = rc;
}


void zRotateMat(float mat[3][3], float rs, float rc)
{
	mat[0][0] = rc;
	mat[0][1] = rs;
	mat[0][2] = 0.0;
    
	mat[1][0] = -rs;
	mat[1][1] = rc;
	mat[1][2] = 0.0;
    
	mat[2][0] = 0.0;
	mat[2][1] = 0.0;
	mat[2][2] = 1.0;
}

void matrixMult(float a[3][3], float b[3][3], float c[3][3])
{
	int x, y;
	float temp[3][3];
    
	for(y=0; y<3; y++)
		for(x=0; x<3; x++)
			temp[y][x] = b[y][0] * a[0][x] + b[y][1] * a[1][x] + b[y][2] * a[2][x];
	for(y=0; y<3; y++)
		for(x=0; x<3; x++)
			c[y][x] = temp[y][x];
}

void hueMatrix(GLfloat mat[3][3], float angle)
{
#define SQRT_2      sqrt(2.0)
#define SQRT_3      sqrt(3.0)
    
	float mag, rot[3][3];
	float xrs, xrc;
	float yrs, yrc;
	float zrs, zrc;
    
	// Rotate the grey vector into positive Z
	mag = SQRT_2;
	xrs = 1.0/mag;
	xrc = 1.0/mag;
	xRotateMat(mat, xrs, xrc);
	mag = SQRT_3;
	yrs = -1.0/mag;
	yrc = SQRT_2/mag;
	yRotateMat(rot, yrs, yrc);
	matrixMult(rot, mat, mat);
    
	// Rotate the hue
	zrs = sin(angle);
	zrc = cos(angle);
	zRotateMat(rot, zrs, zrc);
	matrixMult(rot, mat, mat);
    
	// Rotate the grey vector back into place
	yRotateMat(rot, -yrs, yrc);
	matrixMult(rot,  mat, mat);
	xRotateMat(rot, -xrs, xrc);
	matrixMult(rot,  mat, mat);
}

void premultiplyAlpha(GLfloat mat[3][3], float alpha)
{
    for (int i = 0; i < 3; ++i)
        for (int j = 0; j < 3; ++j)
            mat[i][j] *= alpha;
}
